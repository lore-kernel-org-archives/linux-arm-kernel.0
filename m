From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri,  5 Feb 2016 19:00:47 +0000
Subject: [PATCH 1/6] arm64: dts: qcom: add manual pullup setting to otg.
In-Reply-To: <1454698819-13885-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1454698819-13885-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1454698847-13929-1-git-send-email-srinivas.kandagatla@linaro.org>
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
