From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 22 Apr 2016 17:17:11 -0500
Subject: [PATCH 7/8] dts: qcom: apq8084: Add SCM firmware node
In-Reply-To: <1461363432-5730-1-git-send-email-andy.gross@linaro.org>
References: <1461363432-5730-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1461363432-5730-8-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the firmware node for the SCM

Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index a33a09f..711b6fb 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -86,6 +86,16 @@
 		};
 	};
 
+	firmware {
+		compatible = "simple-bus";
+
+		scm {
+			compatible = "qcom,scm-apq8084";
+			clocks = <&gcc GCC_CE1_CLK> , <&gcc GCC_CE1_AXI_CLK>, <&gcc GCC_CE1_AHB_CLK>;
+			clock-names = "core", "bus", "iface";
+		};
+	};
+
 	cpu-pmu {
 		compatible = "qcom,krait-pmu";
 		interrupts = <1 7 0xf04>;
-- 
1.9.1
