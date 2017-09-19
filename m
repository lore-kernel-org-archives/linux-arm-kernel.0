From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 19 Sep 2017 14:05:47 +0200
Subject: [PATCH 1/2] ARM64: dts: meson-gxm: Add Vega S96 board
In-Reply-To: <1505822748-23431-1-git-send-email-narmstrong@baylibre.com>
References: <1505822748-23431-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1505822748-23431-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Tronsmart Vega S96 is a TV box derived from Amlogic q200 reference design.

Cc: support at tronsmart.com
Signed-off-by: Oleg <balbes-150@yandex.ru>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/Makefile               |  1 +
 arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dts | 39 ++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 7a9f48c..a6c4a06 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -19,6 +19,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxm-nexbox-a1.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q200.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q201.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-rbox-pro.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxm-vega-s96.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dts
new file mode 100644
index 0000000..ba74240
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dts
@@ -0,0 +1,39 @@
+/*
+ * Copyright (c) 2017 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ * Copyright (c) 2017 Oleg <balbes-150@yandex.ru>
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+/dts-v1/;
+
+#include "meson-gxm.dtsi"
+#include "meson-gx-p23x-q20x.dtsi"
+
+/ {
+	compatible = "tronsmart,vega-s96", "amlogic,s912", "amlogic,meson-gxm";
+	model = "Tronsmart Vega S96";
+
+};
+
+&ethmac {
+	pinctrl-0 = <&eth_pins>;
+	pinctrl-names = "default";
+
+	/* Select external PHY by default */
+	phy-handle = <&external_phy>;
+
+	amlogic,tx-delay-ns = <2>;
+
+	/* External PHY is in RGMII */
+	phy-mode = "rgmii";
+};
+
+&external_mdio {
+	external_phy: ethernet-phy at 0 {
+		compatible = "ethernet-phy-id001c.c916", "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+		max-speed = <1000>;
+	};
+};
-- 
1.9.1
