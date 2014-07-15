From: balbi@ti.com (Felipe Balbi)
Date: Tue, 15 Jul 2014 12:56:52 -0500
Subject: [RFC/PATCH 5/5] ARM: dts: am437x-sk-evm: add vpfe support and ov2659
 sensor
In-Reply-To: <1405447012-5340-1-git-send-email-balbi@ti.com>
References: <1405447012-5340-1-git-send-email-balbi@ti.com>
Message-ID: <1405447012-5340-6-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Darren Etheridge <detheridge@ti.com>

Adding necessary dts nodes to enable vpfe and ov2659 sensor on the correct i2c
bus and correct vpfe instance.

Signed-off-by: Darren Etheridge <detheridge@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 63 +++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 859ff3d..ca6b4fe 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -184,6 +184,46 @@
 		>;
 	};
 
+	vpfe0_pins_default: vpfe0_pins_default {
+		pinctrl-single,pins = <
+			0x1b0 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_hd mode 0*/
+			0x1b4 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_vd mode 0*/
+			0x1b8 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_field mode 0*/
+			0x1bc (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_wen mode 0*/
+			0x1c0 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_pclk mode 0*/
+			0x1c4 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data8 mode 0*/
+			0x1c8 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data9 mode 0*/
+			0x208 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data0 mode 0*/
+			0x20c (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data1 mode 0*/
+			0x210 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data2 mode 0*/
+			0x214 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data3 mode 0*/
+			0x218 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data4 mode 0*/
+			0x21c (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data5 mode 0*/
+			0x220 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data6 mode 0*/
+			0x224 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data7 mode 0*/
+		>;
+	};
+
+	vpfe0_pins_sleep: vpfe0_pins_sleep {
+		pinctrl-single,pins = <
+			0x1b0 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			0x1b4 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			0x1b8 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			0x1bc (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			0x1c0 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			0x1c4 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			0x1c8 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			0x208 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			0x20c (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			0x210 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			0x214 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			0x218 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			0x21c (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			0x220 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			0x224 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+		>;
+	};
+
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
@@ -611,3 +655,22 @@
 &wdt {
 	status = "okay";
 };
+
+
+&vpfe0 {
+	status = "okay";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&vpfe0_pins_default>;
+	pinctrl-1 = <&vpfe0_pins_sleep>;
+
+	/* Camera port */
+	port {
+		vpfe0_ep: endpoint {
+			/* remote-endpoint = <&sensor>; add once we have it */
+			if_type = <2>;
+			bus_width = <8>;
+			hdpol = <0>;
+			vdpol = <0>;
+		};
+	};
+};
-- 
2.0.0.390.gcb682f8
