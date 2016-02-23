From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 23 Feb 2016 16:49:46 +0000
Subject: [PATCH v3 1/8] arm64: dts: qcom: add manual pullup setting to otg.
In-Reply-To: <1456246153-18087-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1456246153-18087-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1456246186-18130-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds manual pull up setting for usb otg indicating that the
vbus is vbus is not routed to USB controller/phy therefore enables
pull-up explicitly before starting controller.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index ff7ca44..c1592d4 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -399,6 +399,7 @@
 			qcom,phy-init-sequence = <0x44 0x6B 0x24 0x13>;
 			dr_mode = "peripheral";
 			qcom,otg-control = <2>; // PMIC
+			qcom,manual-pullup;
 
 			clocks = <&gcc GCC_USB_HS_AHB_CLK>,
 				 <&gcc GCC_USB_HS_SYSTEM_CLK>,
-- 
1.9.1
