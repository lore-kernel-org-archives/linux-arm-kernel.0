From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 6 Mar 2014 09:45:58 -0800
Subject: [PATCH 5/6] ARM: BCM63XX: add BCM963138DVT Reference platform DTS
In-Reply-To: <1394127959-3159-1-git-send-email-f.fainelli@gmail.com>
References: <1394127959-3159-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1394127959-3159-6-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a DTS file for the Broadcom BCM963138DVT reference platform board
which leverages the bcm63138.dtsi SoC DTSi file.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/Makefile        |  1 +
 arch/arm/boot/dts/bcm63138dvt.dts | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm63138dvt.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 032030361bef..1e404a51d563 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -47,6 +47,7 @@ dtb-$(CONFIG_ARCH_AT91)	+= sama5d36ek.dtb
 
 dtb-$(CONFIG_ARCH_ATLAS6) += atlas6-evb.dtb
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
+dtb-$(CONFIG_ARCH_BCM_63XX) += bcm63138dvt.dtb
 dtb-$(CONFIG_ARCH_BCM_MOBILE) += bcm11351-brt.dtb \
 	bcm28155-ap.dtb
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
diff --git a/arch/arm/boot/dts/bcm63138dvt.dts b/arch/arm/boot/dts/bcm63138dvt.dts
new file mode 100644
index 000000000000..e212b4731978
--- /dev/null
+++ b/arch/arm/boot/dts/bcm63138dvt.dts
@@ -0,0 +1,18 @@
+/*
+ * Broadcom BCM63138 Reference Board DTS
+ *
+ * Copyright (C) 2014 Broadcom Corporation
+ */
+
+/dts-v1/;
+
+#include "bcm63138.dtsi"
+
+/ {
+	compatible = "BCM963138DVT", "brcm,bcm63138";
+	model = "Broadcom BCM963138DVT";
+
+	memory {
+		reg = <0x0 0x08000000>;
+	};
+};
-- 
1.8.3.2
