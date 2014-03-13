From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Thu, 13 Mar 2014 15:06:47 +0100
Subject: [PATCH v2 3/3] ARM: dts: berlin2q: add the Marvell BG2-Q DMP device
 tree
In-Reply-To: <1394719607-25018-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1394719607-25018-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1394719607-25018-4-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds initial support for the Marvell BG2-Q DMP. The board has 2GB of
memory, an uart activated and what's initially supported by the Marvell
Armada 1500 pro dtsi.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/Makefile                 |  3 ++-
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/berlin2q-marvell-dmp.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 032030361bef..4a1c0cf01b93 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -52,7 +52,8 @@ dtb-$(CONFIG_ARCH_BCM_MOBILE) += bcm11351-brt.dtb \
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
 dtb-$(CONFIG_ARCH_BERLIN) += \
 	berlin2-sony-nsz-gs7.dtb	\
-	berlin2cd-google-chromecast.dtb
+	berlin2cd-google-chromecast.dtb	\
+	berlin2q-marvell-dmp.dtb
 dtb-$(CONFIG_ARCH_DAVINCI) += da850-enbw-cmc.dtb \
 	da850-evm.dtb
 dtb-$(CONFIG_ARCH_DOVE) += dove-cm-a510.dtb \
diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
new file mode 100644
index 000000000000..2da9c41e29d8
--- /dev/null
+++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
@@ -0,0 +1,28 @@
+/*
+ * Copyright (C) 2014 Antoine T?nart <antoine.tenart@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "berlin2q.dtsi"
+
+/ {
+	model = "Marvell BG2-Q DMP";
+	compatible = "marvell,berlin2q-dmp", "marvell,berlin2q", "marvell,berlin";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000>;
+	};
+
+	choosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
1.8.3.2
