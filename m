From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 11 Mar 2015 15:51:20 -0500
Subject: [PATCH v3 4/4] arm64: dts: Add Qualcomm MSM8916 & MTP8916 ids
In-Reply-To: <1426107080-29079-1-git-send-email-galak@codeaurora.org>
References: <1426107080-29079-1-git-send-email-galak@codeaurora.org>
Message-ID: <1426107080-29079-4-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add qcom,msm-id and qcom,board-id to allow bootloader to identify which
device tree to boot on the MTP8916 boards.

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8916-mtp.dts | 3 +++
 arch/arm64/boot/dts/qcom/msm8916.dtsi    | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-mtp.dts b/arch/arm64/boot/dts/qcom/msm8916-mtp.dts
index 784ad92..8be101c 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-mtp.dts
@@ -12,10 +12,13 @@
 
 /dts-v1/;
 
+#include <dt-bindings/arm/qcom-ids.h>
 #include "msm8916-mtp.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. MSM 8916 MTP";
 	compatible = "qcom,msm8916-mtp", "qcom,msm8916-mtp-smb1360",
 			"qcom,msm8916", "qcom,mtp";
+	qcom,board-id = <QCOM_BRD_ID(MTP, 1, 0) QCOM_BRD_SUBTYPE_DEFAULT>,
+			<QCOM_BRD_ID(MTP, 1, 0) QCOM_BRD_SUBTYPE_MTP8916_SMB1360>;
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 957486f..41f1c0f 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -14,10 +14,15 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-msm8916.h>
 #include <dt-bindings/reset/qcom,gcc-msm8916.h>
+#include <dt-bindings/arm/qcom-ids.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. MSM8916";
 	compatible = "qcom,msm8916";
+	qcom,msm-id =	<QCOM_ID_MSM8916 0>,
+			<QCOM_ID_MSM8216 0>,
+			<QCOM_ID_MSM8116 0>,
+			<QCOM_ID_MSM8616 0>;
 
 	interrupt-parent = <&intc>;
 
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
