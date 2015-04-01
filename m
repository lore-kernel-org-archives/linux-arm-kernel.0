From: manabian@gmail.com (Joachim Eastwood)
Date: Wed,  1 Apr 2015 23:20:42 +0200
Subject: [PATCH 5/6] ARM: dts: Add DT for Embedded Artist LPC4357 Developers
 Kit
In-Reply-To: <1427923243-26296-1-git-send-email-manabian@gmail.com>
References: <1427923243-26296-1-git-send-email-manabian@gmail.com>
Message-ID: <1427923243-26296-6-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds basic support for Embedded Artist' LPC4357 Developer's Kit. Board
features a LPC4357 Soc, 32 MB SDRAM, 128 MB NAND Flash, 16 MB SPI
Flash, USB and Ethernet.

More information can be found on:
http://www.embeddedartists.com/products/kits/lpc4357_kit.php

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/Makefile           |  2 ++
 arch/arm/boot/dts/lpc4357-ea4357.dts | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 arch/arm/boot/dts/lpc4357-ea4357.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a1c776b8dcec..cae9917a4198 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -195,6 +195,8 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += \
 	kirkwood-ts219-6282.dtb \
 	kirkwood-ts419-6281.dtb \
 	kirkwood-ts419-6282.dtb
+dtb-$(CONFIG_ARCH_LPC18XX) += \
+	lpc4357-ea4357.dtb
 dtb-$(CONFIG_ARCH_LPC32XX) += \
 	ea3250.dtb phy3250.dtb
 dtb-$(CONFIG_MACH_MESON6) += \
diff --git a/arch/arm/boot/dts/lpc4357-ea4357.dts b/arch/arm/boot/dts/lpc4357-ea4357.dts
new file mode 100644
index 000000000000..39340e355b0a
--- /dev/null
+++ b/arch/arm/boot/dts/lpc4357-ea4357.dts
@@ -0,0 +1,34 @@
+/*
+ * Embedded Artist LPC4357 Developer's Kit
+ *
+ * Copyright 2015 Joachim Eastwood <manabian@gmail.com>
+ *
+ * This code is released using a dual license strategy: BSD/GPL
+ * You can choose the licence that better fits your requirements.
+ *
+ * Released under the terms of 3-clause BSD License
+ * Released under the terms of GNU General Public License Version 2.0
+ *
+ */
+/dts-v1/;
+
+#include "lpc18xx.dtsi"
+#include "lpc4357.dtsi"
+
+/ {
+	model = "Embedded Artist LPC4357 Developer's Kit";
+	compatible = "ea,lpc4357-developers-kit", "nxp,lpc4357";
+
+	chosen {
+		stdout-path = &uart0;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x28000000 0x2000000>; /* 32 MB */
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
1.8.0
