From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 31 Aug 2015 21:09:09 +0530
Subject: [PATCH 2/2] ARM: dts: am437x-gp-evm: Add pinctrl states for usb
In-Reply-To: <cover.1441029572.git.nsekhar@ti.com>
References: <cover.1441029572.git.nsekhar@ti.com>
Message-ID: <4a8a072030c2a82867c6548627739146681b35a5.1441029572.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Gerlach <d-gerlach@ti.com>

Add pinctrl default and sleep states for each usb device.
The only pin that can be controlled is USB_DRVVBUS, this
must be set to MUX_MODE7 (gpio) during sleep to conserve
power.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
[nsekhar at ti.com: move pins to core dwc3]
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 84aa30c3235a..2e990a5f9e95 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -409,6 +409,30 @@
 			0x234 (PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* uart3_rtsn.uart3_rtsn */
 		>;
 	};
+
+	usb1_pins_default: usb1_pins_default {
+		pinctrl-single,pins = <
+			0x2c0 (DS0_PULL_UP_DOWN_EN | PIN_INPUT_PULLDOWN | MUX_MODE0)
+		>;
+	};
+
+	usb1_pins_sleep: usb1_pins_sleep {
+		pinctrl-single,pins = <
+			0x2c0 (DS0_PULL_UP_DOWN_EN | PIN_INPUT_PULLDOWN | MUX_MODE7)
+		>;
+	};
+
+	usb2_pins_default: usb2_pins_default {
+		pinctrl-single,pins = <
+			0x2c4 (DS0_PULL_UP_DOWN_EN | PIN_INPUT_PULLDOWN | MUX_MODE0)
+		>;
+	};
+
+	usb2_pins_sleep: usb2_pins_sleep {
+		pinctrl-single,pins = <
+			0x2c4 (DS0_PULL_UP_DOWN_EN | PIN_INPUT_PULLDOWN | MUX_MODE7)
+		>;
+	};
 };
 
 &i2c0 {
@@ -615,6 +639,9 @@
 &usb1 {
 	dr_mode = "peripheral";
 	status = "okay";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&usb1_pins_default>;
+	pinctrl-1 = <&usb1_pins_sleep>;
 };
 
 &usb2_phy2 {
@@ -624,6 +651,9 @@
 &usb2 {
 	dr_mode = "host";
 	status = "okay";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&usb2_pins_default>;
+	pinctrl-1 = <&usb2_pins_sleep>;
 };
 
 &mac {
-- 
2.4.4.408.g16da57c
