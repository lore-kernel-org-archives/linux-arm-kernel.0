From: mathieu@codeaurora.org (Mathieu Olivari)
Date: Tue, 18 Aug 2015 15:05:37 -0700
Subject: [PATCH 1/2] ARM: qcom: add uart labels to IPQ806x dts
In-Reply-To: <1439935538-13932-1-git-send-email-mathieu@codeaurora.org>
References: <1439935538-13932-1-git-send-email-mathieu@codeaurora.org>
Message-ID: <1439935538-13932-2-git-send-email-mathieu@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want to use references to UART devices from the board specific dts
files, so we'll label them according to their gsbi number.

Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 9834c94..2f270d7 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -159,8 +159,9 @@
 
 			syscon-tcsr = <&tcsr>;
 
-			serial at 12490000 {
-				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
+			uart2: serial at 12490000 {
+				compatible = "qcom,msm-uartdm-v1.3",
+					     "qcom,msm-uartdm";
 				reg = <0x12490000 0x1000>,
 				      <0x12480000 0x1000>;
 				interrupts = <0 195 0x0>;
@@ -197,8 +198,9 @@
 
 			syscon-tcsr = <&tcsr>;
 
-			serial at 16340000 {
-				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
+			uart4: serial at 16340000 {
+				compatible = "qcom,msm-uartdm-v1.3",
+					     "qcom,msm-uartdm";
 				reg = <0x16340000 0x1000>,
 				      <0x16300000 0x1000>;
 				interrupts = <0 152 0x0>;
@@ -234,8 +236,9 @@
 
 			syscon-tcsr = <&tcsr>;
 
-			serial at 1a240000 {
-				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
+			uart5: serial at 1a240000 {
+				compatible = "qcom,msm-uartdm-v1.3",
+					     "qcom,msm-uartdm";
 				reg = <0x1a240000 0x1000>,
 				      <0x1a200000 0x1000>;
 				interrupts = <0 154 0x0>;
-- 
2.1.4
