From: tony@atomide.com (Tony Lindgren)
Date: Fri,  4 Dec 2015 15:31:09 -0800
Subject: [PATCH 6/6] ARM: dts: Add usb support for j5-eco evm
In-Reply-To: <1449271869-7614-1-git-send-email-tony@atomide.com>
References: <1449271869-7614-1-git-send-email-tony@atomide.com>
Message-ID: <1449271869-7614-7-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add usb support for j5-eco evm.

Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra62x-j5eco-evm.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/dra62x-j5eco-evm.dts b/arch/arm/boot/dts/dra62x-j5eco-evm.dts
index 97ac839..7900806 100644
--- a/arch/arm/boot/dts/dra62x-j5eco-evm.dts
+++ b/arch/arm/boot/dts/dra62x-j5eco-evm.dts
@@ -56,4 +56,25 @@
 			DM814X_IOPAD(0x093C, PIN_INPUT_PULLUP |  0x80)	/* GP1[6] */
 			>;
 	};
+
+	usb0_pins: pinmux_usb0_pins {
+		pinctrl-single,pins = <
+			DM814X_IOPAD(0x0c34, PIN_OUTPUT | 0x1)	/* USB0_DRVVBUS */
+			>;
+	};
+};
+
+/* USB0_ID pin state: SW10[1] = 0 cable detection, SW10[1] = 1 ID grounded */
+&usb0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_pins>;
+	dr_mode = "otg";
+};
+
+&usb1_phy {
+	status = "disabled";
+};
+
+&usb1 {
+	status = "disabled";
 };
-- 
2.6.2
