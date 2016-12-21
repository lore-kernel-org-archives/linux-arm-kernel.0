From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 21 Dec 2016 03:49:35 -0800
Subject: [PATCH 1/5] ARM: dts: qcom: apq8064: Add missing scm clock
Message-ID: <20161221114939.19973-1-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per the device tree binding the apq8064 scm node requires the core
clock to be specified, so add this.

Cc: John Stultz <john.stultz@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 268bd470c865..78bf155a52f3 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -303,6 +303,9 @@
 	firmware {
 		scm {
 			compatible = "qcom,scm-apq8064";
+
+			clocks = <&gcc CE3_CORE_CLK>;
+			clock-names = "core";
 		};
 	};
 
-- 
2.11.0
