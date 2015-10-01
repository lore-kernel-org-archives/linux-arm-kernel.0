From: manabian@gmail.com (Joachim Eastwood)
Date: Thu,  1 Oct 2015 22:54:49 +0200
Subject: [PATCH 12/16] ARM: dts: lpc4357-ea4357: add ssp0
In-Reply-To: <1443732893-17145-1-git-send-email-manabian@gmail.com>
References: <1443732893-17145-1-git-send-email-manabian@gmail.com>
Message-ID: <1443732893-17145-13-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SSP0 can be found on the EA4357 Dev Kit on J15 pin 3-6.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
index 9fcc0f357c2d..4d2d74a064c4 100644
--- a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
+++ b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
@@ -389,6 +389,23 @@
 		};
 	};
 
+	ssp0_pins: ssp0-pins {
+		ssp0_sck_miso_mosi {
+			pins = "pf_0", "pf_2", "pf_3";
+			function = "ssp0";
+			slew-rate = <1>;
+			bias-pull-down;
+			input-enable;
+			input-schmitt-disable;
+		};
+
+		ssp0_ssel {
+			pins = "pf_1";
+			function = "ssp0";
+			bias-pull-up;
+		};
+	};
+
 	uart0_pins: uart0-pins {
 		uart0_rx_cfg {
 			pins = "pf_11";
@@ -535,6 +552,13 @@
 	};
 };
 
+&ssp0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&ssp0_pins>;
+	num-cs = <1>;
+};
+
 &uart0 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
1.8.0
