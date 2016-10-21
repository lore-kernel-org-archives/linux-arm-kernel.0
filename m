From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Fri, 21 Oct 2016 16:19:18 -0700
Subject: [PATCH v3 3/4] arm64: dts: msm8996: Add SMEM DT nodes
In-Reply-To: <1477091959-19580-1-git-send-email-spjoshi@codeaurora.org>
References: <1477091959-19580-1-git-send-email-spjoshi@codeaurora.org>
Message-ID: <1477091959-19580-4-git-send-email-spjoshi@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add SMEM and TCSR DT nodes on MSM8996.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sarangdhar Joshi <spjoshi@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 949b096..60d2d20c 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -164,17 +164,34 @@
 
 	};
 
+	tcsr_mutex: hwlock {
+		compatible = "qcom,tcsr-mutex";
+		syscon = <&tcsr_mutex_regs 0 0x1000>;
+		#hwlock-cells = <1>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 	};
 
+	smem {
+		compatible = "qcom,smem";
+		memory-region = <&smem_mem>;
+		hwlocks = <&tcsr_mutex 3>;
+	};
+
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
 		compatible = "simple-bus";
 
+		tcsr_mutex_regs: syscon at 740000 {
+			compatible = "syscon";
+			reg = <0x740000 0x20000>;
+		};
+
 		intc: interrupt-controller at 9bc0000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <3>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
