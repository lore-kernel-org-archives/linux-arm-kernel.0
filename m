From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 17 Jun 2016 22:28:10 +0200
Subject: [PATCH 5/7] ARM: dts: fix the MSM8660 RTC base address
In-Reply-To: <1466195292-28236-1-git-send-email-linus.walleij@linaro.org>
References: <1466195292-28236-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1466195292-28236-7-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RTC was defined on 0x11d but on the MSM8660/APQ8060 it is
actually on 0x1e8. We were saved by the fact that the driver does
not use the reg parameter: instead it uses the compatible string
to figure out where the RTC is.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8660.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 8ee3045f4066..b7d7f0c27ba1 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -211,11 +211,11 @@
 					row-hold = <91500>;
 				};
 
-				rtc at 11d {
+				rtc at 1e8 {
 					compatible = "qcom,pm8058-rtc";
+					reg = <0x1e8>;
 					interrupt-parent = <&pmicintc>;
 					interrupts = <39 1>;
-					reg = <0x11d>;
 					allow-set-time;
 				};
 
-- 
2.4.11
