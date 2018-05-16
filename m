From: sricharan@codeaurora.org (Sricharan R)
Date: Wed, 16 May 2018 18:19:53 +0530
Subject: [PATCH V6 01/12] ARM: dts: ipq4019: Add a default chosen node
In-Reply-To: <1526475004-10341-1-git-send-email-sricharan@codeaurora.org>
References: <1526475004-10341-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1526475004-10341-2-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a 'chosen' node to select the serial console.
This is needed when bootloaders do not pass the
'console=' bootargs.

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi | 8 ++++++++
 arch/arm/boot/dts/qcom-ipq4019.dtsi           | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
index e413b21e..ef8d8c8 100644
--- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
@@ -20,6 +20,14 @@
 	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK01.1";
 	compatible = "qcom,ipq4019";
 
+	aliases {
+		serial0 = &blsp1_uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
 	soc {
 		rng at 22000 {
 			status = "ok";
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 10d112a..ea9202a 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -256,7 +256,7 @@
                         regulator;
                 };
 
-		serial at 78af000 {
+		blsp1_uart1: serial at 78af000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0x78af000 0x200>;
 			interrupts = <0 107 0>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
