From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 31 Jul 2015 00:24:22 +0200
Subject: [PATCH 4/9] ARM: dts: lpc4357-ea4357: add usb0
In-Reply-To: <1438295067-24407-1-git-send-email-manabian@gmail.com>
References: <1438295067-24407-1-git-send-email-manabian@gmail.com>
Message-ID: <1438295067-24407-5-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable USB0 on the EA4357 devkit and setup the required USB0
control pins.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
index 3a3ba16fe690..9ac096746360 100644
--- a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
+++ b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
@@ -221,6 +221,20 @@
 			bias-pull-down;
 		};
 	};
+
+	usb0_pins: usb0-pins {
+		usb0_pwr_enable {
+			pins = "p2_3";
+			function = "usb0";
+		};
+
+		usb0_pwr_fault {
+			pins = "p8_0";
+			function = "usb0";
+			bias-disable;
+			input-enable;
+		};
+	};
 };
 
 &enet_tx_clk {
@@ -253,3 +267,9 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins>;
 };
+
+&usb0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_pins>;
+};
-- 
1.8.0
