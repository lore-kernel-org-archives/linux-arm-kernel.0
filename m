From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 10 Jul 2015 11:32:15 +0200
Subject: [PATCH 1/2] ARM: ux500: define serial port aliases
Message-ID: <1436520735-23692-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enumerates the PL011 serial ports on the Ux500. This is
necessary to do if we want to remove one of the serial ports,
since userspace depends on console to be present on ttyAMA2
and we must not break userspace.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Moved the alias definitions from the core SoC file
  to the toplevel DTS file, as requested by Arnd.

ARM SoC guys: if you find this patch OK, please apply this
directly for fixes, as a prerequisite for patch 2/2, then
apply 2/2.
---
 arch/arm/boot/dts/ste-ccu8540.dts           | 7 +++++++
 arch/arm/boot/dts/ste-ccu9540.dts           | 7 +++++++
 arch/arm/boot/dts/ste-dbx5x0.dtsi           | 6 +++---
 arch/arm/boot/dts/ste-hrefprev60-stuib.dts  | 7 +++++++
 arch/arm/boot/dts/ste-hrefprev60-tvk.dts    | 7 +++++++
 arch/arm/boot/dts/ste-hrefv60plus-stuib.dts | 7 +++++++
 arch/arm/boot/dts/ste-hrefv60plus-tvk.dts   | 7 +++++++
 arch/arm/boot/dts/ste-snowball.dts          | 7 +++++++
 8 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/ste-ccu8540.dts b/arch/arm/boot/dts/ste-ccu8540.dts
index 32dd55e5f4e6..6eaaf638e52e 100644
--- a/arch/arm/boot/dts/ste-ccu8540.dts
+++ b/arch/arm/boot/dts/ste-ccu8540.dts
@@ -17,6 +17,13 @@
 	model = "ST-Ericsson U8540 platform with Device Tree";
 	compatible = "st-ericsson,ccu8540", "st-ericsson,u8540";
 
+	/* This stablilizes the serial port enumeration */
+	aliases {
+		serial0 = &ux500_serial0;
+		serial1 = &ux500_serial1;
+		serial2 = &ux500_serial2;
+	};
+
 	memory at 0 {
 		device_type = "memory";
 		reg = <0x20000000 0x1f000000>, <0xc0000000 0x3f000000>;
diff --git a/arch/arm/boot/dts/ste-ccu9540.dts b/arch/arm/boot/dts/ste-ccu9540.dts
index 651c56d400a4..c8b815819cfe 100644
--- a/arch/arm/boot/dts/ste-ccu9540.dts
+++ b/arch/arm/boot/dts/ste-ccu9540.dts
@@ -16,6 +16,13 @@
 	model = "ST-Ericsson CCU9540 platform with Device Tree";
 	compatible = "st-ericsson,ccu9540", "st-ericsson,u9540";
 
+	/* This stablilizes the serial port enumeration */
+	aliases {
+		serial0 = &ux500_serial0;
+		serial1 = &ux500_serial1;
+		serial2 = &ux500_serial2;
+	};
+
 	memory {
 		reg = <0x00000000 0x20000000>;
 	};
diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 853684ad7773..a75f3289e653 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -971,7 +971,7 @@
 			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
-		uart at 80120000 {
+		ux500_serial0: uart at 80120000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x80120000 0x1000>;
 			interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
@@ -986,7 +986,7 @@
 			status = "disabled";
 		};
 
-		uart at 80121000 {
+		ux500_serial1: uart at 80121000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x80121000 0x1000>;
 			interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>;
@@ -1001,7 +1001,7 @@
 			status = "disabled";
 		};
 
-		uart at 80007000 {
+		ux500_serial2: uart at 80007000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x80007000 0x1000>;
 			interrupts = <0 26 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/ste-hrefprev60-stuib.dts b/arch/arm/boot/dts/ste-hrefprev60-stuib.dts
index 2b1cb5b584b6..18e9795a94f9 100644
--- a/arch/arm/boot/dts/ste-hrefprev60-stuib.dts
+++ b/arch/arm/boot/dts/ste-hrefprev60-stuib.dts
@@ -17,6 +17,13 @@
 	model = "ST-Ericsson HREF (pre-v60) and ST UIB";
 	compatible = "st-ericsson,mop500", "st-ericsson,u8500";
 
+	/* This stablilizes the serial port enumeration */
+	aliases {
+		serial0 = &ux500_serial0;
+		serial1 = &ux500_serial1;
+		serial2 = &ux500_serial2;
+	};
+
 	soc {
 		/* Reset line for the BU21013 touchscreen */
 		i2c at 80110000 {
diff --git a/arch/arm/boot/dts/ste-hrefprev60-tvk.dts b/arch/arm/boot/dts/ste-hrefprev60-tvk.dts
index 59523f866812..24739914e689 100644
--- a/arch/arm/boot/dts/ste-hrefprev60-tvk.dts
+++ b/arch/arm/boot/dts/ste-hrefprev60-tvk.dts
@@ -16,4 +16,11 @@
 / {
 	model = "ST-Ericsson HREF (pre-v60) and TVK1281618 UIB";
 	compatible = "st-ericsson,mop500", "st-ericsson,u8500";
+
+	/* This stablilizes the serial port enumeration */
+	aliases {
+		serial0 = &ux500_serial0;
+		serial1 = &ux500_serial1;
+		serial2 = &ux500_serial2;
+	};
 };
diff --git a/arch/arm/boot/dts/ste-hrefv60plus-stuib.dts b/arch/arm/boot/dts/ste-hrefv60plus-stuib.dts
index 8c6a2de56cf1..c2e1ba019a2f 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus-stuib.dts
+++ b/arch/arm/boot/dts/ste-hrefv60plus-stuib.dts
@@ -19,6 +19,13 @@
 	model = "ST-Ericsson HREF (v60+) and ST UIB";
 	compatible = "st-ericsson,hrefv60+", "st-ericsson,u8500";
 
+	/* This stablilizes the serial port enumeration */
+	aliases {
+		serial0 = &ux500_serial0;
+		serial1 = &ux500_serial1;
+		serial2 = &ux500_serial2;
+	};
+
 	soc {
 		/* Reset line for the BU21013 touchscreen */
 		i2c at 80110000 {
diff --git a/arch/arm/boot/dts/ste-hrefv60plus-tvk.dts b/arch/arm/boot/dts/ste-hrefv60plus-tvk.dts
index d53cccdce776..ebd8547e98f1 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus-tvk.dts
+++ b/arch/arm/boot/dts/ste-hrefv60plus-tvk.dts
@@ -18,4 +18,11 @@
 / {
 	model = "ST-Ericsson HREF (v60+) and TVK1281618 UIB";
 	compatible = "st-ericsson,hrefv60+", "st-ericsson,u8500";
+
+	/* This stablilizes the serial port enumeration */
+	aliases {
+		serial0 = &ux500_serial0;
+		serial1 = &ux500_serial1;
+		serial2 = &ux500_serial2;
+	};
 };
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index 9edadc37719f..acf14cebef81 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -18,6 +18,13 @@
 	model = "Calao Systems Snowball platform with device tree";
 	compatible = "calaosystems,snowball-a9500", "st-ericsson,u9500";
 
+	/* This stablilizes the serial port enumeration */
+	aliases {
+		serial0 = &ux500_serial0;
+		serial1 = &ux500_serial1;
+		serial2 = &ux500_serial2;
+	};
+
 	memory {
 		reg = <0x00000000 0x20000000>;
 	};
-- 
2.4.3
