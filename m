From: andy.gross@linaro.org (Andy Gross)
Date: Fri,  3 Jun 2016 18:25:29 -0500
Subject: [Patch v6 09/10] dts: qcom: msm8974: Add SCM firmware node
In-Reply-To: <1464996330-16952-1-git-send-email-andy.gross@linaro.org>
References: <1464996330-16952-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1464996330-16952-10-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the Qualcomm SCM firmware node.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 6f16426..036be41 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -260,6 +260,14 @@
 		};
 	};
 
+	firmware {
+		scm {
+			compatible = "qcom,scm";
+			clocks = <&gcc GCC_CE1_CLK>, <&gcc GCC_CE1_AXI_CLK>, <&gcc GCC_CE1_AHB_CLK>;
+			clock-names = "core", "bus", "iface";
+		};
+	};
+
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.9.1
