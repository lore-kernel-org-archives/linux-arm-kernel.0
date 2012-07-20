From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 20 Jul 2012 19:35:51 +0200
Subject: [PATCH 16/16] ARM: Kirkwood: Replace mrvl with marvell
In-Reply-To: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
References: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
Message-ID: <1342805751-18048-17-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It has been decided to use marvell, not mrvl, in the compatibility
property. Search & replace.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 Documentation/devicetree/bindings/mtd/orion-nand.txt |    4 ++--
 arch/arm/boot/dts/kirkwood-dns320.dts                |    2 +-
 arch/arm/boot/dts/kirkwood-dns325.dts                |    2 +-
 arch/arm/boot/dts/kirkwood-dnskw.dtsi                |    2 +-
 arch/arm/boot/dts/kirkwood-dreamplug.dts             |    2 +-
 arch/arm/boot/dts/kirkwood-goflexnet.dts             |    2 +-
 arch/arm/boot/dts/kirkwood-ib62x0.dts                |    2 +-
 arch/arm/boot/dts/kirkwood-iconnect.dts              |    2 +-
 arch/arm/boot/dts/kirkwood-lschlv2.dts               |    2 +-
 arch/arm/boot/dts/kirkwood-lsxhl.dts                 |    2 +-
 arch/arm/boot/dts/kirkwood-ts219.dtsi                |    2 +-
 arch/arm/boot/dts/kirkwood.dtsi                      |    6 +++---
 arch/arm/mach-kirkwood/board-dt.c                    |    2 +-
 drivers/mtd/nand/orion_nand.c                        |    2 +-
 drivers/rtc/rtc-mv.c                                 |    2 +-
 15 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/orion-nand.txt b/Documentation/devicetree/bindings/mtd/orion-nand.txt
index b2356b7..2d6ab66 100644
--- a/Documentation/devicetree/bindings/mtd/orion-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/orion-nand.txt
@@ -1,7 +1,7 @@
 NAND support for Marvell Orion SoC platforms
 
 Required properties:
-- compatible : "mrvl,orion-nand".
+- compatible : "marvell,orion-nand".
 - reg : Base physical address of the NAND and length of memory mapped
 	region
 
@@ -24,7 +24,7 @@ nand at f4000000 {
 	ale = <1>;
 	bank-width = <1>;
 	chip-delay = <25>;
-	compatible = "mrvl,orion-nand";
+	compatible = "marvell,orion-nand";
 	reg = <0xf4000000 0x400>;
 
 	partition at 0 {
diff --git a/arch/arm/boot/dts/kirkwood-dns320.dts b/arch/arm/boot/dts/kirkwood-dns320.dts
index d41e204..5bb0bf3 100644
--- a/arch/arm/boot/dts/kirkwood-dns320.dts
+++ b/arch/arm/boot/dts/kirkwood-dns320.dts
@@ -4,7 +4,7 @@
 
 / {
 	model = "D-Link DNS-320 NAS (Rev A1)";
-	compatible = "dlink,dns-320-a1", "dlink,dns-320", "dlink,dns-kirkwood", "mrvl,kirkwood-88f6281", "mrvl,kirkwood";
+	compatible = "dlink,dns-320-a1", "dlink,dns-320", "dlink,dns-kirkwood", "marvell,kirkwood-88f6281", "marvell,kirkwood";
 
 	memory {
 		device_type = "memory";
diff --git a/arch/arm/boot/dts/kirkwood-dns325.dts b/arch/arm/boot/dts/kirkwood-dns325.dts
index 2662efc..d430713 100644
--- a/arch/arm/boot/dts/kirkwood-dns325.dts
+++ b/arch/arm/boot/dts/kirkwood-dns325.dts
@@ -4,7 +4,7 @@
 
 / {
 	model = "D-Link DNS-325 NAS (Rev A1)";
-	compatible = "dlink,dns-325-a1", "dlink,dns-325", "dlink,dns-kirkwood", "mrvl,kirkwood-88f6281", "mrvl,kirkwood";
+	compatible = "dlink,dns-325-a1", "dlink,dns-325", "dlink,dns-kirkwood", "marvell,kirkwood-88f6281", "marvell,kirkwood";
 
 	memory {
 		device_type = "memory";
diff --git a/arch/arm/boot/dts/kirkwood-dnskw.dtsi b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
index 2bad626..7408655 100644
--- a/arch/arm/boot/dts/kirkwood-dnskw.dtsi
+++ b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
@@ -2,7 +2,7 @@
 
 / {
 	model = "D-Link DNS NASes (kirkwood-based)";
-	compatible = "dlink,dns-kirkwood", "mrvl,kirkwood-88f6281", "mrvl,kirkwood";
+	compatible = "dlink,dns-kirkwood", "marvell,kirkwood-88f6281", "marvell,kirkwood";
 
 	gpio_keys {
 		compatible = "gpio-keys";
diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/kirkwood-dreamplug.dts
index 77fec4e..26e281f 100644
--- a/arch/arm/boot/dts/kirkwood-dreamplug.dts
+++ b/arch/arm/boot/dts/kirkwood-dreamplug.dts
@@ -4,7 +4,7 @@
 
 / {
 	model = "Globalscale Technologies Dreamplug";
-	compatible = "globalscale,dreamplug-003-ds2001", "globalscale,dreamplug", "mrvl,kirkwood-88f6281", "mrvl,kirkwood";
+	compatible = "globalscale,dreamplug-003-ds2001", "globalscale,dreamplug", "marvell,kirkwood-88f6281", "marvell,kirkwood";
 
 	memory {
 		device_type = "memory";
diff --git a/arch/arm/boot/dts/kirkwood-goflexnet.dts b/arch/arm/boot/dts/kirkwood-goflexnet.dts
index f6974d1..7c8238f 100644
--- a/arch/arm/boot/dts/kirkwood-goflexnet.dts
+++ b/arch/arm/boot/dts/kirkwood-goflexnet.dts
@@ -4,7 +4,7 @@
 
 / {
 	model = "Seagate GoFlex Net";
-	compatible = "seagate,goflexnet", "mrvl,kirkwood-88f6281", "mrvl,kirkwood";
+	compatible = "seagate,goflexnet", "marvell,kirkwood-88f6281", "marvell,kirkwood";
 
 	memory {
 		device_type = "memory";
diff --git a/arch/arm/boot/dts/kirkwood-ib62x0.dts b/arch/arm/boot/dts/kirkwood-ib62x0.dts
index ab35288..66794ed 100644
--- a/arch/arm/boot/dts/kirkwood-ib62x0.dts
+++ b/arch/arm/boot/dts/kirkwood-ib62x0.dts
@@ -4,7 +4,7 @@
 
 / {
 	model = "RaidSonic ICY BOX IB-NAS62x0 (Rev B)";
-	compatible = "raidsonic,ib-nas6210-b", "raidsonic,ib-nas6220-b", "raidsonic,ib-nas6210", "raidsonic,ib-nas6220", "raidsonic,ib-nas62x0",  "mrvl,kirkwood-88f6281", "mrvl,kirkwood";
+	compatible = "raidsonic,ib-nas6210-b", "raidsonic,ib-nas6220-b", "raidsonic,ib-nas6210", "raidsonic,ib-nas6220", "raidsonic,ib-nas62x0",  "marvell,kirkwood-88f6281", "marvell,kirkwood";
 
 	memory {
 		device_type = "memory";
diff --git a/arch/arm/boot/dts/kirkwood-iconnect.dts b/arch/arm/boot/dts/kirkwood-iconnect.dts
index b77b38f..52d9470 100644
--- a/arch/arm/boot/dts/kirkwood-iconnect.dts
+++ b/arch/arm/boot/dts/kirkwood-iconnect.dts
@@ -4,7 +4,7 @@
 
 / {
 	model = "Iomega Iconnect";
-	compatible = "iom,iconnect-1.1", "iom,iconnect", "mrvl,kirkwood-88f6281", "mrvl,kirkwood";
+	compatible = "iom,iconnect-1.1", "iom,iconnect", "marvell,kirkwood-88f6281", "marvell,kirkwood";
 
 	memory {
 		device_type = "memory";
diff --git a/arch/arm/boot/dts/kirkwood-lschlv2.dts b/arch/arm/boot/dts/kirkwood-lschlv2.dts
index 37649b5..9510c9e 100644
--- a/arch/arm/boot/dts/kirkwood-lschlv2.dts
+++ b/arch/arm/boot/dts/kirkwood-lschlv2.dts
@@ -4,7 +4,7 @@
 
 / {
 	model = "Buffalo Linkstation LS-CHLv2";
-	compatible = "buffalo,lschlv2", "buffalo,lsxl", "mrvl,kirkwood-88f6281", "mrvl,kirkwood";
+	compatible = "buffalo,lschlv2", "buffalo,lsxl", "marvell,kirkwood-88f6281", "marvell,kirkwood";
 
 	memory {
 		device_type = "memory";
diff --git a/arch/arm/boot/dts/kirkwood-lsxhl.dts b/arch/arm/boot/dts/kirkwood-lsxhl.dts
index eb3c071..739019c 100644
--- a/arch/arm/boot/dts/kirkwood-lsxhl.dts
+++ b/arch/arm/boot/dts/kirkwood-lsxhl.dts
@@ -4,7 +4,7 @@
 
 / {
 	model = "Buffalo Linkstation LS-XHL";
-	compatible = "buffalo,lsxhl", "buffalo,lsxl", "mrvl,kirkwood-88f6281", "mrvl,kirkwood";
+	compatible = "buffalo,lsxhl", "buffalo,lsxl", "marvell,kirkwood-88f6281", "marvell,kirkwood";
 
 	memory {
 		device_type = "memory";
diff --git a/arch/arm/boot/dts/kirkwood-ts219.dtsi b/arch/arm/boot/dts/kirkwood-ts219.dtsi
index b4a789a..64ea27c 100644
--- a/arch/arm/boot/dts/kirkwood-ts219.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ts219.dtsi
@@ -2,7 +2,7 @@
 
 / {
 	model = "QNAP TS219 family";
-	compatible = "qnap,ts219", "mrvl,kirkwood";
+	compatible = "qnap,ts219", "marvell,kirkwood";
 
 	memory {
 		device_type = "memory";
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index fbb96ce..cef9616 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -1,7 +1,7 @@
 /include/ "skeleton.dtsi"
 
 / {
-	compatible = "mrvl,kirkwood";
+	compatible = "marvell,kirkwood";
 	interrupt-parent = <&intc>;
 
 	intc: interrupt-controller {
@@ -55,7 +55,7 @@
 		};
 
 		rtc at 10300 {
-			compatible = "mrvl,kirkwood-rtc", "mrvl,orion-rtc";
+			compatible = "marvell,kirkwood-rtc", "marvell,orion-rtc";
 			reg = <0x10300 0x20>;
 			interrupts = <53>;
 		};
@@ -89,7 +89,7 @@
 			cle = <0>;
 			ale = <1>;
 			bank-width = <1>;
-			compatible = "mrvl,orion-nand";
+			compatible = "marvell,orion-nand";
 			reg = <0x3000000 0x400>;
 			chip-delay = <25>;
 			/* set partition map and/or chip-delay in board dts */
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 43142cf..e4eb450 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -32,7 +32,7 @@ struct of_dev_auxdata kirkwood_auxdata_lookup[] __initdata = {
 		       NULL),
 	OF_DEV_AUXDATA("marvell,orion-wdt", 0xf1020300, "orion_wdt", NULL),
 	OF_DEV_AUXDATA("marvell,orion-sata", 0xf1080000, "sata_mv.0", NULL),
-	OF_DEV_AUXDATA("mrvl,orion-nand", 0xf4000000, "orion_nand", NULL),
+	OF_DEV_AUXDATA("marvell,orion-nand", 0xf4000000, "orion_nand", NULL),
 	{},
 };
 
diff --git a/drivers/mtd/nand/orion_nand.c b/drivers/mtd/nand/orion_nand.c
index 513dc88..f8a5563 100644
--- a/drivers/mtd/nand/orion_nand.c
+++ b/drivers/mtd/nand/orion_nand.c
@@ -214,7 +214,7 @@ static int __devexit orion_nand_remove(struct platform_device *pdev)
 
 #ifdef CONFIG_OF
 static struct of_device_id orion_nand_of_match_table[] = {
-	{ .compatible = "mrvl,orion-nand", },
+	{ .compatible = "marvell,orion-nand", },
 	{},
 };
 #endif
diff --git a/drivers/rtc/rtc-mv.c b/drivers/rtc/rtc-mv.c
index b2185f4..ebc1649 100644
--- a/drivers/rtc/rtc-mv.c
+++ b/drivers/rtc/rtc-mv.c
@@ -297,7 +297,7 @@ static int __exit mv_rtc_remove(struct platform_device *pdev)
 
 #ifdef CONFIG_OF
 static struct of_device_id rtc_mv_of_match_table[] = {
-	{ .compatible = "mrvl,orion-rtc", },
+	{ .compatible = "marvell,orion-rtc", },
 	{}
 };
 #endif
-- 
1.7.10
