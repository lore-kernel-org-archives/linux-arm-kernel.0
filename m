From: balbi@ti.com (Felipe Balbi)
Date: Thu, 4 Dec 2014 11:01:57 -0600
Subject: [PATCH 4/6] arm: boot: dts: am437x-sk: add explicit pinmux for both
 USB instances
In-Reply-To: <1417712519-4615-1-git-send-email-balbi@ti.com>
References: <1417712519-4615-1-git-send-email-balbi@ti.com>
Message-ID: <1417712519-4615-5-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch just makes USB[01]_DRVVBUS signal
explicitly muxed. Note that board already has
a discrete pulldown, so we're not adding any
pulls here.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 68b9529..5ca9ee7 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -329,6 +329,18 @@
 			0x1c (PIN_OUTPUT_PULLDOWN | MUX_MODE7) /* gpcm_ad7.gpio1_7 */
 		>;
 	};
+
+	usb1_pins: usb1_pins {
+		pinctrl-single,pins = <
+			0x2c0 (PIN_OUTPUT | MUX_MODE0) /* usb0_drvvbus.usb0_drvvbus */
+		>;
+	};
+
+	usb2_pins: usb2_pins {
+		pinctrl-single,pins = <
+			0x2c4 (PIN_OUTPUT | MUX_MODE0) /* usb0_drvvbus.usb0_drvvbus */
+		>;
+	};
 };
 
 &i2c0 {
@@ -485,6 +497,8 @@
 &usb1 {
 	dr_mode = "peripheral";
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb1_pins>;
 };
 
 &usb2_phy2 {
@@ -494,6 +508,8 @@
 &usb2 {
 	dr_mode = "host";
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb2_pins>;
 };
 
 &qspi {
-- 
2.1.0.GIT
