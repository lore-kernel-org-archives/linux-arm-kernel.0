From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Thu, 10 May 2018 23:20:00 +0200
Subject: [PATCH] ARM: dts: BCM5301X: Switch D-Link DIR-885L to the new
 partitions syntax
Message-ID: <20180510212000.11110-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

This new syntax is slightly better designed & uses "compatible" string.
For details see Documentation/devicetree/bindings/mtd/partition.txt .

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
index 494dbd39658c..d173bcd93b91 100644
--- a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
+++ b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
@@ -26,9 +26,15 @@
 
 	nand: nand at 18028000 {
 		nandcs at 0 {
-			partition at 0 {
-				label = "firmware";
-				reg = <0x00000000 0x08000000>;
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				partition at 0 {
+					label = "firmware";
+					reg = <0x00000000 0x08000000>;
+				};
 			};
 		};
 	};
-- 
2.13.6
