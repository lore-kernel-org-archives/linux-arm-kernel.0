From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 23 Feb 2016 16:50:19 +0000
Subject: [PATCH v3 4/8] arm64: dts: qcom: add lpass node
In-Reply-To: <1456246153-18087-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1456246153-18087-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1456246219-18257-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds lpass node to the SOC.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index c1592d4..a6fddce 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -343,6 +343,32 @@
 			status = "disabled";
 		};
 
+		lpass: lpass at 07708000 {
+			status = "disabled";
+			compatible = "qcom,lpass-cpu-apq8016";
+			clocks = <&gcc GCC_ULTAUDIO_AHBFABRIC_IXFABRIC_CLK>,
+				 <&gcc GCC_ULTAUDIO_PCNOC_MPORT_CLK>,
+				 <&gcc GCC_ULTAUDIO_PCNOC_SWAY_CLK>,
+				 <&gcc GCC_ULTAUDIO_LPAIF_PRI_I2S_CLK>,
+				 <&gcc GCC_ULTAUDIO_LPAIF_SEC_I2S_CLK>,
+				 <&gcc GCC_ULTAUDIO_LPAIF_SEC_I2S_CLK>,
+				 <&gcc GCC_ULTAUDIO_LPAIF_AUX_I2S_CLK>;
+
+			clock-names = "ahbix-clk",
+					"pcnoc-mport-clk",
+					"pcnoc-sway-clk",
+					"mi2s-bit-clk0",
+					"mi2s-bit-clk1",
+					"mi2s-bit-clk2",
+					"mi2s-bit-clk3";
+			#sound-dai-cells = <1>;
+
+			interrupts = <0 160 0>;
+			interrupt-names = "lpass-irq-lpaif";
+			reg = <0x07708000 0x10000>;
+			reg-names = "lpass-lpaif";
+		};
+
 		sdhc_1: sdhci at 07824000 {
 			compatible = "qcom,sdhci-msm-v4";
 			reg = <0x07824900 0x11c>, <0x07824000 0x800>;
-- 
1.9.1
