From: markus.mayer@linaro.org (Markus Mayer)
Date: Wed, 19 Jun 2013 16:24:14 -0700
Subject: [PATCH] ARM: bcm281xx: Adding bcm28155-ap.dts
Message-ID: <1371684254-15189-1-git-send-email-markus.mayer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the BCM28155 AP board.

Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
Acked-by: Christian Daudt <csd@broadcom.com>
---
 arch/arm/boot/dts/Makefile        |    3 ++-
 arch/arm/boot/dts/bcm28155-ap.dts |   29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/bcm28155-ap.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f0895c5..187f336 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -40,7 +40,8 @@ dtb-$(CONFIG_ARCH_AT91)	+= sama5d34ek.dtb
 dtb-$(CONFIG_ARCH_AT91)	+= sama5d35ek.dtb
 
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
-dtb-$(CONFIG_ARCH_BCM) += bcm11351-brt.dtb
+dtb-$(CONFIG_ARCH_BCM) += bcm11351-brt.dtb \
+	bcm28155-ap.dtb
 dtb-$(CONFIG_ARCH_DAVINCI) += da850-enbw-cmc.dtb \
 	da850-evm.dtb
 dtb-$(CONFIG_ARCH_DOVE) += dove-cm-a510.dtb \
diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
new file mode 100644
index 0000000..0d66db6
--- /dev/null
+++ b/arch/arm/boot/dts/bcm28155-ap.dts
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2013 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/dts-v1/;
+
+#include "bcm11351.dtsi"
+
+/ {
+	model = "BCM28155 AP board";
+	compatible = "bcm,bcm28155-ap", "bcm,bcm11351";
+
+	memory {
+		reg = <0x80000000 0x40000000>; /* 1 GB */
+	};
+
+	uart at 3e000000 {
+		status = "okay";
+	};
+};
-- 
1.7.9.5
