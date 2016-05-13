From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 12 May 2016 22:47:00 -0500
Subject: [Patch v5 7/8] dts: qcom: apq8084: Add SCM firmware node
In-Reply-To: <1463111221-6963-1-git-send-email-andy.gross@linaro.org>
References: <1463111221-6963-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1463111221-6963-8-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the firmware node for the SCM

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index a33a09f..7c2df06 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -86,6 +86,14 @@
 		};
 	};
 
+	firmware {
+		scm {
+			compatible = "qcom,scm";
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
