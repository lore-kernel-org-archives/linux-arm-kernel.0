From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 17 Aug 2017 11:33:06 +0200
Subject: [PATCH 7/7] ARM: dts: stm32: Enable USB FS on stm32f746-disco
In-Reply-To: <1502962386-6683-1-git-send-email-amelie.delaunay@st.com>
References: <1502962386-6683-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1502962386-6683-8-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables USB FS on stm32f746-disco (Host mode) with 5V VBUS
enable.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32f746-disco.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746-disco.dts b/arch/arm/boot/dts/stm32f746-disco.dts
index 0d38e9a..c683040 100644
--- a/arch/arm/boot/dts/stm32f746-disco.dts
+++ b/arch/arm/boot/dts/stm32f746-disco.dts
@@ -67,6 +67,14 @@
 		clocks = <&rcc 0 STM32F7_AHB1_CLOCK(OTGHSULPI)>;
 		clock-names = "main_clk";
 	};
+
+	/* This turns on vbus for otg fs for host mode (dwc2) */
+	vcc5v_otg_fs: vcc5v-otg-fs-regulator {
+		compatible = "regulator-fixed";
+		gpio = <&gpiod 5 0>;
+		regulator-name = "vcc5_host1";
+		regulator-always-on;
+	};
 };
 
 &clk_hse {
@@ -87,3 +95,10 @@
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&usbotg_fs {
+	dr_mode = "host";
+	pinctrl-0 = <&usbotg_fs_pins_a>;
+	pinctrl-names = "default";
+	status = "okay";
+};
-- 
2.7.4
