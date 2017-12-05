From: tyler@opensourcefoundries.com (tyler at opensourcefoundries.com)
Date: Tue,  5 Dec 2017 14:27:06 -0800
Subject: [PATCH v1 5/6] ARM: dts: imx7d-sbc-iot: enable PCIe peripheral
In-Reply-To: <20171205222707.11302-1-tyler@opensourcefoundries.com>
References: <20171205222707.11302-1-tyler@opensourcefoundries.com>
Message-ID: <20171205222707.11302-6-tyler@opensourcefoundries.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tyler Baker <tyler@opensourcefoundries.com>

Add a PCIe device tree node to enable PCIe support.

Signed-off-by: Tyler Baker <tyler@opensourcefoundries.com>
---
 arch/arm/boot/dts/imx7d-sbc-iot-imx7.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-sbc-iot-imx7.dts b/arch/arm/boot/dts/imx7d-sbc-iot-imx7.dts
index 67aa4b7..7f45fa2 100644
--- a/arch/arm/boot/dts/imx7d-sbc-iot-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-sbc-iot-imx7.dts
@@ -79,6 +79,12 @@
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
@@ -119,6 +125,13 @@
 	};
 };
 
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	reset-gpio = <&gpio2 29 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
 &uart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2>;
-- 
2.9.3
