From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 14 Aug 2014 17:11:26 -0700
Subject: [PATCH v2 4/5] ARM: BCM63XX: add BCM963138DVT Reference platform DTS
In-Reply-To: <1408061487-20984-1-git-send-email-f.fainelli@gmail.com>
References: <1408061487-20984-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1408061487-20984-5-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a DTS file for the Broadcom BCM963138DVT reference platform board
which leverages the bcm63138.dtsi SoC DTSi file.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:
- consistently use the prefix 963138 since this is a reference board
- enable UARTs for that reference board so we get to a prompt

 arch/arm/boot/dts/Makefile         |  1 +
 arch/arm/boot/dts/bcm963138dvt.dts | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm963138dvt.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b8c5cd3ddeb9..7ffe736abcf8 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -53,6 +53,7 @@ dtb-$(CONFIG_ARCH_ATLAS6) += atlas6-evb.dtb
 dtb-$(CONFIG_ARCH_AXXIA) += axm5516-amarillo.dtb
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
 dtb-$(CONFIG_ARCH_BCM_5301X) += bcm4708-netgear-r6250.dtb
+dtb-$(CONFIG_ARCH_BCM_63XX) += bcm963138dvt.dtb
 dtb-$(CONFIG_ARCH_BCM_MOBILE) += bcm28155-ap.dtb \
 	bcm21664-garnet.dtb
 dtb-$(CONFIG_ARCH_BERLIN) += \
diff --git a/arch/arm/boot/dts/bcm963138dvt.dts b/arch/arm/boot/dts/bcm963138dvt.dts
new file mode 100644
index 000000000000..c5f7620881f7
--- /dev/null
+++ b/arch/arm/boot/dts/bcm963138dvt.dts
@@ -0,0 +1,25 @@
+/*
+ * Broadcom BCM63138 Reference Board DTS
+ */
+
+/dts-v1/;
+
+#include "bcm63138.dtsi"
+
+/ {
+	compatible = "brcm,BCM963138DVT", "brcm,bcm63138";
+	model = "Broadcom BCM963138DVT";
+
+	memory {
+		reg = <0x0 0x08000000>;
+	};
+
+};
+
+&serial0 {
+	status = "okay";
+};
+
+&serial1 {
+	status = "okay";
+};
-- 
1.9.1
