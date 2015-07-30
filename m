From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 31 Jul 2015 00:24:26 +0200
Subject: [PATCH 8/9] ARM: dts: lpc4350-hitex-eval: add ethernet
In-Reply-To: <1438295067-24407-1-git-send-email-manabian@gmail.com>
References: <1438295067-24407-1-git-send-email-manabian@gmail.com>
Message-ID: <1438295067-24407-9-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>

Enable Ethernet and add pin muxing and set the correct
frequency on the enet tx clock input.

Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc4350-hitex-eval.dts | 60 ++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/lpc4350-hitex-eval.dts b/arch/arm/boot/dts/lpc4350-hitex-eval.dts
index 1dab22150510..1150052731af 100644
--- a/arch/arm/boot/dts/lpc4350-hitex-eval.dts
+++ b/arch/arm/boot/dts/lpc4350-hitex-eval.dts
@@ -37,6 +37,55 @@
 };
 
 &pinctrl {
+	enet_mii_pins: enet-mii-pins {
+		enet_mii_rxd0_3_cfg {
+			pins = "p1_15", "p0_0", "p9_3", "p9_2";
+			function = "enet";
+			bias-disable;
+			input-enable;
+		};
+
+		enet_mii_txd0_3_cfg {
+			pins = "p1_18", "p1_20", "p9_4", "p9_5";
+			function = "enet";
+			bias-disable;
+		};
+
+		enet_mii_crs_col_cfg {
+			pins = "p9_0", "p9_6";
+			function = "enet";
+			bias-disable;
+			input-enable;
+		};
+
+		enet_mii_rx_clk_dv_er_cfg {
+			pins = "pc_0", "p1_16", "p9_1";
+			function = "enet";
+			bias-disable;
+			input-enable;
+		};
+
+		enet_mii_tx_clk_en_cfg {
+			pins = "p1_19", "p0_1";
+			function = "enet";
+			bias-disable;
+			input-enable;
+		};
+
+		enet_mdio_cfg {
+			pins = "p1_17";
+			function = "enet";
+			bias-disable;
+			input-enable;
+		};
+
+		enet_mdc_cfg {
+			pins = "pc_1";
+			function = "enet";
+			bias-disable;
+		};
+	};
+
 	uart0_pins: uart0-pins {
 		uart0_rx_cfg {
 			pins = "pf_11";
@@ -54,6 +103,17 @@
 	};
 };
 
+&enet_tx_clk {
+	clock-frequency = <25000000>;
+};
+
+&mac {
+	status = "okay";
+	phy-mode = "mii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&enet_mii_pins>;
+};
+
 &uart0 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
1.8.0
