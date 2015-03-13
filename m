From: sricharan@codeaurora.org (Sricharan R)
Date: Fri, 13 Mar 2015 23:19:51 +0530
Subject: [PATCH 5/6] dts: msm8974: Add blsp2_bam dma node
In-Reply-To: <1426268992-19298-1-git-send-email-sricharan@codeaurora.org>
References: <1426268992-19298-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1426268992-19298-6-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index e265ec1..3f648ae 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -247,5 +247,15 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
+		blsp2_dma: dma at f9944000 {
+			compatible = "qcom,bam-v1.4.0";
+			reg = <0xf9944000 0x19000>;
+			interrupts = <0 239 0>;
+			clocks = <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+		};
 	};
 };
-- 
1.8.2.1
