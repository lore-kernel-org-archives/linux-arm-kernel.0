From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 16 Jun 2015 13:31:12 -0700
Subject: [PATCH 1/5] ARM: dts: qcom: Replace gpio node with pinctrl node
In-Reply-To: <1434486676-21812-1-git-send-email-sboyd@codeaurora.org>
References: <1434486676-21812-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1434486676-21812-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a proper pinctrl driver for the gpio block we
can change the compatible field here and configure the pinmux on
msm8960 devices.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8960.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index a02b984cc68d..1ae3fe828e59 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -73,11 +73,10 @@
 			cpu-offset = <0x80000>;
 		};
 
-		msmgpio: gpio at 800000 {
-			compatible = "qcom,msm-gpio";
+		msmgpio: pinctrl at 800000 {
+			compatible = "qcom,msm8960-pinctrl";
 			gpio-controller;
 			#gpio-cells = <2>;
-			ngpio = <150>;
 			interrupts = <0 16 0x4>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
