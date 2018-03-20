From: sricharan@codeaurora.org (Sricharan R)
Date: Tue, 20 Mar 2018 09:28:49 +0530
Subject: [PATCH v3 06/13] ARM: dts: ipq4019: Add ipq4019-ap.dk04.1-c1 board
 file
In-Reply-To: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
References: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1521518336-5467-7-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/boot/dts/Makefile                      |  1 +
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b59e99b..4f209fb 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -747,6 +747,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-apq8084-ifc6540.dtb \
 	qcom-apq8084-mtp.dtb \
 	qcom-ipq4019-ap.dk01.1-c1.dtb \
+	qcom-ipq4019-ap.dk04.1-c1.dtb \
 	qcom-ipq8064-ap148.dtb \
 	qcom-msm8660-surf.dtb \
 	qcom-msm8960-cdp.dtb \
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
new file mode 100644
index 0000000..871ac3f
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, The Linux Foundation. All rights reserved.
+
+#include "qcom-ipq4019-ap.dk04.1.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK04.1-C1";
+
+	soc {
+		qpic_bam: dma at 7984000 {
+			status = "ok";
+		};
+
+		nand: qpic-nand at 79b0000 {
+			pinctrl-0 = <&nand_pins>;
+			pinctrl-names = "default";
+			status = "ok";
+		};
+	};
+};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
