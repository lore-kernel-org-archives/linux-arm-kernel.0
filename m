From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 21 Jun 2016 18:22:42 +0100
Subject: [PATCH v2 1/8] arm64: dts: db820c: add basic board support
In-Reply-To: <1466529769-2674-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1466529769-2674-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1466529769-2674-2-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds apq8096 db820c basic support with serial port.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile            |  1 +
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts  | 21 +++++++++++++++++
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 34 ++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8096-db820c.dts
 create mode 100644 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index fa1f661..5dd05de 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -1,5 +1,6 @@
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb msm8916-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-mtp.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
new file mode 100644
index 0000000..c1d8919
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -0,0 +1,21 @@
+/*
+ * Copyright (c) 2014-2016, The Linux Foundation. All rights reserved.
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
+/dts-v1/;
+
+#include "apq8096-db820c.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. DB820c";
+	compatible = "qcom,apq8096-sbc";
+};
diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
new file mode 100644
index 0000000..01916a5
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -0,0 +1,34 @@
+/*
+ * Copyright (c) 2014-2016, The Linux Foundation. All rights reserved.
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
+#include "msm8996.dtsi"
+
+/ {
+	aliases {
+		serial0 = &blsp2_uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+
+	soc {
+		serial at 75b0000 {
+			label = "LS-UART1";
+			status = "okay";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp2_uart1_2pins_default>;
+			pinctrl-1 = <&blsp2_uart1_2pins_sleep>;
+		};
+	};
+};
-- 
2.7.4
