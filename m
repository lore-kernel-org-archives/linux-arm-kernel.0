From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun, 13 Nov 2016 22:23:49 +0100
Subject: [PATCH v2 06/19] ARM: dts: armada-370-xp: Fixup bootrom DT warning
In-Reply-To: <20161113212402.3060-1-gregory.clement@free-electrons.com>
References: <20161113212402.3060-1-gregory.clement@free-electrons.com>
Message-ID: <20161113212402.3060-7-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bootrom has a reg property so the unit name should contain an address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi | 2 +-
 arch/arm/boot/dts/armada-xp.dtsi  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 079494e52554..7598fb013355 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -65,7 +65,7 @@
 	soc {
 		compatible = "marvell,armada370-mbus", "simple-bus";
 
-		bootrom {
+		bootrom at 01_e0_0 {
 			compatible = "marvell,bootrom";
 			reg = <MBUS_ID(0x01, 0xe0) 0 0x100000>;
 		};
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index bb8f7dcaf656..5e596b64f48e 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -64,7 +64,7 @@
 	soc {
 		compatible = "marvell,armadaxp-mbus", "simple-bus";
 
-		bootrom {
+		bootrom at 01_1d_0 {
 			compatible = "marvell,bootrom";
 			reg = <MBUS_ID(0x01, 0x1d) 0 0x100000>;
 		};
-- 
2.10.2
