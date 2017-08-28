From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Mon, 28 Aug 2017 16:20:16 +0200
Subject: [PATCHv2 5/7] ARM: dts: stm32: Enable USB HS on stm32f746-disco
In-Reply-To: <1503930018-536-1-git-send-email-amelie.delaunay@st.com>
References: <1503930018-536-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1503930018-536-6-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables USB HS on stm32f746-disco (Host mode).

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32f746-disco.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746-disco.dts b/arch/arm/boot/dts/stm32f746-disco.dts
index 18f6560..8f0c3d5 100644
--- a/arch/arm/boot/dts/stm32f746-disco.dts
+++ b/arch/arm/boot/dts/stm32f746-disco.dts
@@ -61,6 +61,12 @@
 		serial0 = &usart1;
 	};
 
+	usbotg_hs_phy: usb-phy {
+		#phy-cells = <0>;
+		compatible = "usb-nop-xceiv";
+		clocks = <&rcc 0 STM32F7_AHB1_CLOCK(OTGHSULPI)>;
+		clock-names = "main_clk";
+	};
 };
 
 &clk_hse {
@@ -72,3 +78,12 @@
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&usbotg_hs {
+	dr_mode = "host";
+	phys = <&usbotg_hs_phy>;
+	phy-names = "usb2-phy";
+	pinctrl-0 = <&usbotg_hs_pins_b>;
+	pinctrl-names = "default";
+	status = "okay";
+};
-- 
2.7.4
