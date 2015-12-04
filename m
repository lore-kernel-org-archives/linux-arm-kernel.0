From: tony@atomide.com (Tony Lindgren)
Date: Fri,  4 Dec 2015 15:31:07 -0800
Subject: [PATCH 4/6] ARM: dts: Add usb support for dm814x-evm
In-Reply-To: <1449271869-7614-1-git-send-email-tony@atomide.com>
References: <1449271869-7614-1-git-send-email-tony@atomide.com>
Message-ID: <1449271869-7614-5-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add usb support for dm814x-evm

Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm8148-evm.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/dm8148-evm.dts b/arch/arm/boot/dts/dm8148-evm.dts
index 08d01c3..e070862 100644
--- a/arch/arm/boot/dts/dm8148-evm.dts
+++ b/arch/arm/boot/dts/dm8148-evm.dts
@@ -56,4 +56,28 @@
 			DM814X_IOPAD(0x093C, PIN_INPUT_PULLUP |  0x80)	/* GP1[6] */
 			>;
 	};
+
+	usb0_pins: pinmux_usb0_pins {
+		pinctrl-single,pins = <
+			DM814X_IOPAD(0x0c34, PIN_OUTPUT | 0x1)	/* USB0_DRVVBUS */
+			>;
+	};
+
+	usb1_pins: pinmux_usb1_pins {
+		pinctrl-single,pins = <
+			DM814X_IOPAD(0x0834, PIN_OUTPUT | 0x80)	/* USB1_DRVVBUS */
+			>;
+	};
+};
+
+&usb0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_pins>;
+	dr_mode = "host";
+};
+
+&usb1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb1_pins>;
+	dr_mode = "host";
 };
-- 
2.6.2
