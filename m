From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 12 May 2016 22:47:01 -0500
Subject: [Patch v5 8/8] arm64: dts: msm8916: Add SCM firmware node
In-Reply-To: <1463111221-6963-1-git-send-email-andy.gross@linaro.org>
References: <1463111221-6963-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1463111221-6963-9-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the devicetree node for the SCM firmware.

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 9681200..01c7b0c 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -122,6 +122,14 @@
 		hwlocks = <&tcsr_mutex 3>;
 	};
 
+	firmware {
+		scm {
+			compatible = "qcom,scm";
+			clocks = <&gcc GCC_CRYPTO_CLK>, <&gcc GCC_CRYPTO_AXI_CLK>, <&gcc GCC_CRYPTO_AHB_CLK>;
+			clock-names = "core", "bus", "iface";
+		};
+	};
+
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.9.1
