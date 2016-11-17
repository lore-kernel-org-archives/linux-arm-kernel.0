From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 00:04:55 +0100
Subject: [PATCH v3 06/19] ARM: dts: armada-370-xp: Fixup bootrom DT warning
In-Reply-To: <20161117230508.28539-1-gregory.clement@free-electrons.com>
References: <20161117230508.28539-1-gregory.clement@free-electrons.com>
Message-ID: <20161117230508.28539-7-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bootrom has a reg property so the unit name should contain an address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi | 6 +++++-
 arch/arm/boot/dts/armada-xp.dtsi  | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 079494e52554..c0b821e8a03a 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -65,7 +65,11 @@
 	soc {
 		compatible = "marvell,armada370-mbus", "simple-bus";
 
-		bootrom {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		bootrom at 1e000000000 {
 			compatible = "marvell,bootrom";
 			reg = <MBUS_ID(0x01, 0xe0) 0 0x100000>;
 		};
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index bb8f7dcaf656..8d86c6f61299 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -64,7 +64,11 @@
 	soc {
 		compatible = "marvell,armadaxp-mbus", "simple-bus";
 
-		bootrom {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		bootrom at 11d00000000 {
 			compatible = "marvell,bootrom";
 			reg = <MBUS_ID(0x01, 0x1d) 0 0x100000>;
 		};
-- 
2.10.2
