From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  8 Jul 2016 11:12:01 +0200
Subject: [PATCH 3/4] ARM: dts: add EBI2 to the Qualcomm MSM8660 DTSI
In-Reply-To: <1467969122-6552-1-git-send-email-linus.walleij@linaro.org>
References: <1467969122-6552-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1467969122-6552-4-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the external bus interface EBI2 to the MSM8660 device
tree, albeit with status = "disabled" so that devices actually
using EBI2 can turn it on if needed.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8660.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index acbe71febe13..c7cb4a7a84dd 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -140,6 +140,18 @@
 			};
 		};
 
+		ebi2 at 1a100000 {
+			compatible = "qcom,ebi2";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			reg = <0x1a100000 0x1000>, <0x1a110000 0x1000>;
+			reg-names = "ebi2", "xmem";
+			clocks = <&gcc EBI2_2X_CLK>, <&gcc EBI2_CLK>;
+			clock-names = "ebi2x", "ebi2";
+			status = "disabled";
+		};
+
 		qcom,ssbi at 500000 {
 			compatible = "qcom,ssbi";
 			reg = <0x500000 0x1000>;
-- 
2.7.4
