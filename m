From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 15 Feb 2018 16:54:40 +0100
Subject: [PATCH 3/3] ARM: dts: stm32: enable USB HS on stm32f769-disco
In-Reply-To: <1518710080-18164-1-git-send-email-amelie.delaunay@st.com>
References: <1518710080-18164-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1518710080-18164-4-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables USB HS on stm32f749-disco in OTG (DRD) mode.
The USB connector used will determine the role of USB OTG controller.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32f769-disco.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dts/stm32f769-disco.dts
index 4463ca1..427bafe 100644
--- a/arch/arm/boot/dts/stm32f769-disco.dts
+++ b/arch/arm/boot/dts/stm32f769-disco.dts
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
 
 &cec {
@@ -78,3 +84,12 @@
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&usbotg_hs {
+	dr_mode = "otg";
+	phys = <&usbotg_hs_phy>;
+	phy-names = "usb2-phy";
+	pinctrl-0 = <&usbotg_hs_pins_a>;
+	pinctrl-names = "default";
+	status = "okay";
+};
-- 
2.7.4
