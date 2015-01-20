From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Tue, 20 Jan 2015 07:24:56 +0100
Subject: [PATCH 2/2] ARM: BCM5301X: Add DT for Buffalo WZR-900DHP
In-Reply-To: <1421735096-8238-1-git-send-email-zajec5@gmail.com>
References: <1421735096-8238-1-git-send-email-zajec5@gmail.com>
Message-ID: <1421735096-8238-2-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 arch/arm/boot/dts/Makefile                        |  3 +-
 arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts | 37 +++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ff4a5ae..0de664e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -61,7 +61,8 @@ dtb-$(CONFIG_ARCH_BCM_5301X) += \
 	bcm4708-netgear-r6250.dtb \
 	bcm4708-netgear-r6300-v2.dtb \
 	bcm47081-asus-rt-n18u.dtb \
-	bcm47081-buffalo-wzr-600dhp2.dtb
+	bcm47081-buffalo-wzr-600dhp2.dtb \
+	bcm47081-buffalo-wzr-900dhp.dtb
 dtb-$(CONFIG_ARCH_BCM_63XX) += bcm963138dvt.dtb
 dtb-$(CONFIG_ARCH_BCM_CYGNUS) += bcm911360_entphn.dtb \
 	bcm911360k.dtb \
diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts b/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
new file mode 100644
index 0000000..b5352c0
--- /dev/null
+++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
@@ -0,0 +1,37 @@
+/*
+ * Broadcom BCM470X / BCM5301X ARM platform code.
+ * DTS for Buffalo WZR-900DHP
+ *
+ * Copyright (C) 2015 Rafa? Mi?ecki <zajec5@gmail.com>
+ *
+ * Licensed under the GNU/GPL. See COPYING for details.
+ */
+
+/dts-v1/;
+
+#include "bcm47081.dtsi"
+
+/ {
+	compatible = "buffalo,wzr-900dhp", "brcm,bcm47081", "brcm,bcm4708";
+	model = "Buffalo WZR-900DHP (BCM47081)";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+	};
+
+	memory {
+		reg = <0x00000000 0x08000000>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		restart {
+			label = "Reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
-- 
1.8.4.5
