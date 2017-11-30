From: tyler@opensourcefoundries.com (tyler at opensourcefoundries.com)
Date: Thu, 30 Nov 2017 12:14:32 -0800
Subject: [PATCH 6/8] ARM: dts: imx7d-sbc-iot: enable PCIe peripheral
In-Reply-To: <20171130201434.14122-1-tyler@opensourcefoundries.com>
References: <20171130201434.14122-1-tyler@opensourcefoundries.com>
Message-ID: <20171130201434.14122-7-tyler@opensourcefoundries.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tyler Baker <tyler@opensourcefoundries.com>

Add a PCIe device tree node to enable PCIe support.

Signed-off-by: Tyler Baker <tyler@opensourcefoundries.com>
---
 arch/arm/boot/dts/imx7d-sbc-iot-imx7.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-sbc-iot-imx7.dts b/arch/arm/boot/dts/imx7d-sbc-iot-imx7.dts
index 50dfdd3..7b21366 100644
--- a/arch/arm/boot/dts/imx7d-sbc-iot-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-sbc-iot-imx7.dts
@@ -127,6 +127,12 @@
 		>;
 	};
 
+	pinctrl_pcie: pciegrp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_BDR1__GPIO2_IO29		0x34 /* PCIe RST */
+		>;
+	};
+
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
 			MX7D_PAD_LCD_ENABLE__UART2_DCE_TX	0x79 /* P7-12 */
@@ -201,6 +207,14 @@
 	};
 };
 
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	reset-gpio = <&gpio2 29 GPIO_ACTIVE_LOW>;
+	phy-ref-clk = <1>;
+	status = "okay";
+};
+
 &uart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2>;
-- 
2.9.3
