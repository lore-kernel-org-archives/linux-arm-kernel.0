From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 31 Jul 2015 00:24:25 +0200
Subject: [PATCH 7/9] ARM: dts: lpc4350-hitex-eval: add pinctrl and uart0 muxing
In-Reply-To: <1438295067-24407-1-git-send-email-manabian@gmail.com>
References: <1438295067-24407-1-git-send-email-manabian@gmail.com>
Message-ID: <1438295067-24407-8-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>

Setup pin muxing and properties for the debug console on uart0.

Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc4350-hitex-eval.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/lpc4350-hitex-eval.dts b/arch/arm/boot/dts/lpc4350-hitex-eval.dts
index 4ebdb54cc9ce..1dab22150510 100644
--- a/arch/arm/boot/dts/lpc4350-hitex-eval.dts
+++ b/arch/arm/boot/dts/lpc4350-hitex-eval.dts
@@ -36,6 +36,26 @@
 	};
 };
 
+&pinctrl {
+	uart0_pins: uart0-pins {
+		uart0_rx_cfg {
+			pins = "pf_11";
+			function = "uart0";
+			input-schmitt-disable;
+			bias-disable;
+			input-enable;
+		};
+
+		uart0_tx_cfg {
+			pins = "pf_10";
+			function = "uart0";
+			bias-pull-down;
+		};
+	};
+};
+
 &uart0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
 };
-- 
1.8.0
