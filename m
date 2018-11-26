From: pn@denx.de (Parthiban Nallathambi)
Date: Mon, 26 Nov 2018 11:09:40 +0100
Subject: [PATCH v3 4/4] arm64: dts: actions: s700-cubieboard7: Enable SIRQ
Message-ID: <20181126100940.2944780-1-pn@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl definitions for Actions Semiconductor S700 SIRQ external
interrupt controller.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
---
 .../boot/dts/actions/s700-cubieboard7.dts     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
index 28f3f4a0f7f0..af44fd0456cf 100644
--- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
+++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
@@ -37,3 +37,22 @@
 &uart3 {
 	status = "okay";
 };
+
+&sirq {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sirq2_default>;
+};
+
+&pinctrl {
+	sirq2_default: sirq2_default {
+		pinmux {
+			groups = "sirq2_dummy";
+			function = "sirq2";
+		};
+
+		pinconf {
+			pins = "sirq2";
+			bias-pull-pin-default;
+		};
+	};
+};
-- 
2.17.2
