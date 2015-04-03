From: manabian@gmail.com (Joachim Eastwood)
Date: Fri,  3 Apr 2015 23:16:07 +0200
Subject: [PATCH 6/6] ARM: dts: lpc4357-ea4357: add pinctrl and uart0 muxing
In-Reply-To: <1428095767-6286-1-git-send-email-manabian@gmail.com>
References: <1428095767-6286-1-git-send-email-manabian@gmail.com>
Message-ID: <1428095767-6286-7-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc4357-ea4357.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/lpc4357-ea4357.dts b/arch/arm/boot/dts/lpc4357-ea4357.dts
index 39340e355b0a..c2b85f8e6e31 100644
--- a/arch/arm/boot/dts/lpc4357-ea4357.dts
+++ b/arch/arm/boot/dts/lpc4357-ea4357.dts
@@ -29,6 +29,25 @@
 	};
 };
 
+&pinctrl {
+	uart0_pins: uart0-pins {
+		uart0_rx_cfg {
+			pins = "pf_11";
+			function = "uart0";
+			bias-disable;
+			input-enable;
+		};
+
+		uart0_tx_cfg {
+			pins = "pf_10";
+			function = "uart0";
+			bias-disable;
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
