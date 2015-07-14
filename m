From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 14 Jul 2015 15:39:50 +0200
Subject: [PATCH 15/17] ARM: dts: lpc4357-ea4357: add uart3
In-Reply-To: <1436881192-23930-1-git-send-email-manabian@gmail.com>
References: <1436881192-23930-1-git-send-email-manabian@gmail.com>
Message-ID: <1436881192-23930-16-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable UART3 that is routed to the J17 DSUB9 connector on
the EA4357 devkit.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
index 0d04a8e8dbc1..3a3ba16fe690 100644
--- a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
+++ b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
@@ -205,6 +205,22 @@
 			bias-pull-down;
 		};
 	};
+
+	uart3_pins: uart3-pins {
+		uart3_rx_cfg {
+			pins = "p2_4";
+			function = "uart3";
+			input-schmitt-disable;
+			bias-disable;
+			input-enable;
+		};
+
+		uart3_tx_cfg {
+			pins = "p9_3";
+			function = "uart3";
+			bias-pull-down;
+		};
+	};
 };
 
 &enet_tx_clk {
@@ -231,3 +247,9 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins>;
 };
+
+&uart3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+};
-- 
1.8.0
