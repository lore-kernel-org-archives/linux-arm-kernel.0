From: galak@codeaurora.org (Kumar Gala)
Date: Mon, 23 Mar 2015 17:51:05 -0500
Subject: [PATCH] arm64: dts: Add Qualcomm APQ8016 SBC evaluation board dts
Message-ID: <1427151065-29867-1-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial device tree support for Qualcomm APQ8016 SBC Evaluation board.
This board is also referred to as the DragonBoard 410c.

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/Makefile         |  2 +-
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts  | 22 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 33 +++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc.dts
 create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 360ec4c..8e94af6 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -1,4 +1,4 @@
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-mtp.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb msm8916-mtp.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
new file mode 100644
index 0000000..3c563e7
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -0,0 +1,22 @@
+/*
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
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
+#include <dt-bindings/arm/qcom-ids.h>
+#include "apq8016-sbc.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. APQ 8016 SBC";
+	compatible = "qcom,apq8016-sbc", "qcom,apq8016", "qcom,sbc";
+};
diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
new file mode 100644
index 0000000..703a4f1
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -0,0 +1,33 @@
+/*
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
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
+#include "msm8916.dtsi"
+
+/ {
+	aliases {
+		serial0 = &blsp1_uart2;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+
+	soc {
+		serial at 78b0000 {
+			status = "okay";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp1_uart2_default>;
+			pinctrl-1 = <&blsp1_uart2_sleep>;
+		};
+	};
+};
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
