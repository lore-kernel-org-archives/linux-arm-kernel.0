From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 00:04:58 +0100
Subject: [PATCH v3 09/19] ARM: dts: armada-370-xp: Fixup sa-ram DT warning
In-Reply-To: <20161117230508.28539-1-gregory.clement@free-electrons.com>
References: <20161117230508.28539-1-gregory.clement@free-electrons.com>
Message-ID: <20161117230508.28539-10-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sa-ram which is a mmio-sram has a reg property so the unit name should
contain an address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi | 6 +++++-
 arch/arm/boot/dts/armada-xp.dtsi  | 8 ++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index c0b821e8a03a..7ba3e609a5ae 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -266,7 +266,11 @@
 			};
 		};
 
-		crypto_sram: sa-sram {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		crypto_sram: sa-sram at 90100000000 {
 			compatible = "mmio-sram";
 			reg = <MBUS_ID(0x09, 0x01) 0 0x800>;
 			reg-names = "sram";
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index e282ef819be8..395eb9ffb53b 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -234,7 +234,11 @@
 			};
 		};
 
-		crypto_sram0: sa-sram0 {
+		/* The following unit addresses (for sa-sram) are composed of
+		 * the target value (bit [40-47]), attributes value (bits
+		 * [32-39], and the address value in the window memory: [0-31].
+		 */
+		crypto_sram0: sa-sram at 90900000000 {
 			compatible = "mmio-sram";
 			reg = <MBUS_ID(0x09, 0x09) 0 0x800>;
 			clocks = <&gateclk 23>;
@@ -243,7 +247,7 @@
 			ranges = <0 MBUS_ID(0x09, 0x09) 0 0x800>;
 		};
 
-		crypto_sram1: sa-sram1 {
+		crypto_sram1: sa-sram at 90500000000 {
 			compatible = "mmio-sram";
 			reg = <MBUS_ID(0x09, 0x05) 0 0x800>;
 			clocks = <&gateclk 23>;
-- 
2.10.2
