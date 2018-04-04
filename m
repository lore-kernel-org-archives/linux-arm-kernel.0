From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Wed,  4 Apr 2018 15:14:21 +0200
Subject: [PATCH 4.18] ARM: dts: BCM5301X: Switch Luxul XWC-1000 to the new
 fixed partitions syntax
Message-ID: <20180404131421.28651-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

This new syntax is slightly better designed & uses "compatible" string.
For details see Documentation/devicetree/bindings/mtd/partition.txt .

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts b/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
index 50d65d8fbd9a..5efb6f31164d 100644
--- a/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
+++ b/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
@@ -26,9 +26,15 @@
 
 	nand: nand at 18028000 {
 		nandcs at 0 {
-			partition at 0 {
-				label = "ubi";
-				reg = <0x00000000 0x08000000>;
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				partition at 0 {
+					label = "ubi";
+					reg = <0x00000000 0x08000000>;
+				};
 			};
 		};
 	};
-- 
2.11.0
