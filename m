From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 17 Jun 2016 16:13:59 +0100
Subject: [PATCH 02/16] arm64: dts: msm8996: add blsp2_uart1 pinctrl
In-Reply-To: <1466176454-28084-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1466176454-28084-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1466176454-28084-3-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds 2pin and 4 pin uart pinctrl support for blsp2_uart1

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi | 65 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi      |  1 +
 2 files changed, 66 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi

diff --git a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
new file mode 100644
index 0000000..4d1dba7
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
@@ -0,0 +1,65 @@
+/*
+ * Copyright (c) 2013-2016, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+&msmgpio {
+
+	blsp2_uart1_2pins_default: blsp2_uart1_2pins {
+		pinmux {
+			function = "blsp_uart8";
+			pins = "gpio4", "gpio5";
+		};
+		pinconf {
+			pins = "gpio4", "gpio5";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp2_uart1_2pins_sleep: blsp2_uart1_2pins_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio4", "gpio5";
+		};
+		pinconf {
+			pins = "gpio4", "gpio5";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	blsp2_uart1_4pins_default: blsp2_uart1_4pins {
+		pinmux {
+			function = "blsp_uart8";
+			pins = "gpio4", "gpio5", "gpio6", "gpio7";
+		};
+
+		pinconf {
+			pins = "gpio4", "gpio5", "gpio6", "gpio7";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp2_uart1_4pins_sleep: blsp2_uart1_4pins_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio4", "gpio5", "gpio6", "gpio7";
+		};
+
+		pinconf {
+			pins = "gpio4", "gpiio5", "gpio6", "gpio7";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 8bf382f..22b770f 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -267,3 +267,4 @@
 		};
 	};
 };
+#include "msm8996-pins.dtsi"
-- 
2.7.4
