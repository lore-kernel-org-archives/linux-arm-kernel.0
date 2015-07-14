From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 14 Jul 2015 15:39:49 +0200
Subject: [PATCH 14/17] ARM: dts: lpc4357-ea4357: add ethernet
In-Reply-To: <1436881192-23930-1-git-send-email-manabian@gmail.com>
References: <1436881192-23930-1-git-send-email-manabian@gmail.com>
Message-ID: <1436881192-23930-15-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable Ethernet and add pin muxing and set the correct
frequency on the enet tx clock input.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts | 73 +++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
index ee9d97350d34..0d04a8e8dbc1 100644
--- a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
+++ b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
@@ -88,6 +88,68 @@
 };
 
 &pinctrl {
+	enet_rmii_pins: enet-rmii-pins {
+		enet_rmii_rxd_cfg {
+			pins = "p1_15", "p0_0";
+			function = "enet";
+			slew-rate = <1>;
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+
+		enet_rmii_txd_cfg {
+			pins = "p1_18", "p1_20";
+			function = "enet";
+			slew-rate = <1>;
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+
+		enet_rmii_rx_dv_cfg {
+			pins = "p1_16";
+			function = "enet";
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+
+		enet_rmii_tx_en_cfg {
+			pins = "p0_1";
+			function = "enet";
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+
+		enet_ref_clk_cfg {
+			pins = "p1_19";
+			function = "enet";
+			slew-rate = <1>;
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+
+		enet_mdio_cfg {
+			pins = "p1_17";
+			function = "enet";
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+
+		enet_mdc_cfg {
+			pins = "pc_1";
+			function = "enet";
+			slew-rate = <1>;
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+	};
+
 	gpio_joystick_pins: gpio-joystick-pins {
 		gpio_joystick_cfg {
 			pins =	"p9_0", "p9_1", "pa_1", "pa_2", "pa_3";
@@ -145,6 +207,17 @@
 	};
 };
 
+&enet_tx_clk {
+	clock-frequency = <50000000>;
+};
+
+&mac {
+	status = "okay";
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&enet_rmii_pins>;
+};
+
 &mmcsd {
 	status = "okay";
 	bus-width = <4>;
-- 
1.8.0
