From: jaz@semihalf.com (Grzegorz Jaszczyk)
Date: Thu,  4 Aug 2016 12:14:07 +0200
Subject: [PATCH v2 04/17] ARM: dts: mvebu: a385-db-ap: add default partition
 description for NAND
In-Reply-To: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
References: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
Message-ID: <1470305660-6601-5-git-send-email-jaz@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 385 Access Point Development board contains NAND FLSH which is
already enabled in existing dts. Nevertheless the default partition
description was missing.

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-385-db-ap.dts | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/armada-385-db-ap.dts b/arch/arm/boot/dts/armada-385-db-ap.dts
index a18f516..6648a3f 100644
--- a/arch/arm/boot/dts/armada-385-db-ap.dts
+++ b/arch/arm/boot/dts/armada-385-db-ap.dts
@@ -182,15 +182,35 @@
 
 			nfc: flash at d0000 {
 				status = "okay";
-				#address-cells = <1>;
-				#size-cells = <1>;
-
 				num-cs = <1>;
 				nand-ecc-strength = <4>;
 				nand-ecc-step-size = <512>;
 				marvell,nand-keep-config;
 				marvell,nand-enable-arbiter;
 				nand-on-flash-bbt;
+
+				partitions {
+					compatible = "fixed-partitions";
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					partition at 0 {
+						label = "U-Boot";
+						reg = <0x00000000 0x00800000>;
+						read-only;
+					};
+
+					partition at 800000 {
+						label = "uImage";
+						reg = <0x00800000 0x00400000>;
+						read-only;
+					};
+
+					partition at c00000 {
+						label = "Root";
+						reg = <0x00c00000 0x3f400000>;
+					};
+				};
 			};
 
 			usb3 at f0000 {
-- 
1.8.3.1
