From: tharvey@gateworks.com (Tim Harvey)
Date: Fri,  6 Nov 2015 14:40:32 -0800
Subject: [PATCH 3/3] ARM: dts: imx: ventana: Allow HDMI and LVDS to work
 simultaneously
In-Reply-To: <1446849632-20333-1-git-send-email-tharvey@gateworks.com>
References: <1446849632-20333-1-git-send-email-tharvey@gateworks.com>
Message-ID: <1446849632-20333-4-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently it is not possible to have HDMI and LVDS working simultaneously,
because both ports try to use PLL5.

Move the LVDS clock parent to PLL3_USB_OTG, so that HDMI and LVDS can be
driven from independent sources.

With this change the LDB pixel clock goes to 68.57 MHz, which is still
within the valid range for the displays supported by the Ventana boards.

Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Tim Harvey <tharvey@gateworks.com>

---
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 7 +++++++
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 7 +++++++
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 7 +++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 1b66328..9709728 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -151,6 +151,13 @@
 	status = "okay";
 };
 
+&clks {
+	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
+	                  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
+	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
+	                  <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
+};
+
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 5172de0..dc1cd13 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -152,6 +152,13 @@
 	status = "okay";
 };
 
+&clks {
+	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
+	                  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
+	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
+	                  <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
+};
+
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index aad051b..d8aa22e 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -142,6 +142,13 @@
 	status = "okay";
 };
 
+&clks {
+	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
+	                  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
+	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
+	                  <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
+};
+
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
-- 
1.9.1
