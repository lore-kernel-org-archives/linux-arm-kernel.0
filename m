From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Tue,  1 Dec 2015 21:41:15 +0530
Subject: [PATCH v2] arm64: dts: qcom: Add apq8096 dragonboard dts skeletons
Message-ID: <1448986275-16807-1-git-send-email-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new dtsi and dts files for the apq8096 dragonboards with just
a serial device used as debug console

While at it, also rearrange the Makefile so we have one dtb per line
so as to be consistent with whats done on other platforms.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/Makefile                 |  4 ++-
 arch/arm64/boot/dts/qcom/apq8096-dragonboard.dts  | 21 ++++++++++++++++
 arch/arm64/boot/dts/qcom/apq8096-dragonboard.dtsi | 30 +++++++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8096-dragonboard.dts
 create mode 100644 arch/arm64/boot/dts/qcom/apq8096-dragonboard.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index fa1f661..0fd9a17 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -1,5 +1,7 @@
-dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb msm8916-mtp.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-mtp.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-dragonboard.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/qcom/apq8096-dragonboard.dts b/arch/arm64/boot/dts/qcom/apq8096-dragonboard.dts
new file mode 100644
index 0000000..65f4a6a
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/apq8096-dragonboard.dts
@@ -0,0 +1,21 @@
+/*
+ * Copyright (c) 2014-2015, The Linux Foundation. All rights reserved.
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
+#include "apq8096-dragonboard.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. APQ 8096 DragonBoard";
+	compatible = "qcom,apq8096-dragonboard";
+};
diff --git a/arch/arm64/boot/dts/qcom/apq8096-dragonboard.dtsi b/arch/arm64/boot/dts/qcom/apq8096-dragonboard.dtsi
new file mode 100644
index 0000000..9bab5c0
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/apq8096-dragonboard.dtsi
@@ -0,0 +1,30 @@
+/*
+ * Copyright (c) 2014-2015, The Linux Foundation. All rights reserved.
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
+			status = "okay";
+		};
+	};
+};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
