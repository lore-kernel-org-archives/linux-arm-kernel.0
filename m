From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Thu, 31 May 2012 09:21:03 +0200
Subject: [PATCH v2] ARM: at91: add support for Telit EVK GE863-PRO3
Message-ID: <1338448863-3938-1-git-send-email-fabio.porcedda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 - changes for v2
   - add empty line before the Signed-off-by line

 arch/arm/boot/dts/evk_ge863_pro3.dts |   57 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/Makefile.boot     |    1 +
 2 files changed, 58 insertions(+)
 create mode 100644 arch/arm/boot/dts/evk_ge863_pro3.dts

diff --git a/arch/arm/boot/dts/evk_ge863_pro3.dts b/arch/arm/boot/dts/evk_ge863_pro3.dts
new file mode 100644
index 0000000..bcd5ae1
--- /dev/null
+++ b/arch/arm/boot/dts/evk_ge863_pro3.dts
@@ -0,0 +1,57 @@
+/*
+ * evk_ge863_pro3.dts - Device Tree file for Telit EVK GE863-PRO3
+ *
+ * Copyright (C) 2012 Telit,
+ *               2012 Fabio Porcedda <fabio.porcedda@gmail.com>
+ *
+ * Licensed under GPLv2 or later.
+ */
+/dts-v1/;
+/include/ "at91sam9260.dtsi"
+
+/ {
+	model = "Telit EVK GE863-PRO3";
+	compatible = "telit,evk_ge863-pro3", "atmel,at91sam9260", "atmel,at91sam9";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 root=ubi0:rootfs ubi.mtd=1 rootfstype=ubifs";
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		main_clock: clock at 0 {
+			compatible = "atmel,osc", "fixed-clock";
+			clock-frequency = <6000000>;
+		};
+	};
+
+	ahb {
+		apb {
+			dbgu: serial at fffff200 {
+				status = "okay";
+			};
+
+			usb1: gadget at fffa4000 {
+				atmel,vbus-gpio = <&pioC 4 0>;
+				status = "okay";
+			};
+		};
+
+
+		nand0: nand at 40000000 {
+			nand-bus-width = <8>;
+			nand-ecc-mode = "soft";
+			nand-on-flash-bbt;
+			status = "okay";
+
+			root at 07c0000 {
+				label = "root";
+				reg = <0x7c0000 0x7840000>;
+			};
+
+		};
+	};
+};
diff --git a/arch/arm/mach-at91/Makefile.boot b/arch/arm/mach-at91/Makefile.boot
index 9e84fe4..7bb44f0 100644
--- a/arch/arm/mach-at91/Makefile.boot
+++ b/arch/arm/mach-at91/Makefile.boot
@@ -16,6 +16,7 @@ endif
 # Keep dtb files sorted alphabetically for each SoC
 # sam9260
 dtb-$(CONFIG_MACH_AT91SAM_DT) += ethernut5.dtb
+dtb-$(CONFIG_MACH_AT91SAM_DT) += evk_ge863_pro3.dtb
 dtb-$(CONFIG_MACH_AT91SAM_DT) += tny_a9260.dtb
 dtb-$(CONFIG_MACH_AT91SAM_DT) += usb_a9260.dtb
 # sam9263
-- 
1.7.10
