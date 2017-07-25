From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 24 Jul 2017 22:47:05 -0700
Subject: [PATCH 5/5] arm64: dts: msm8996: Add QFPROM node
In-Reply-To: <20170725054705.20674-1-bjorn.andersson@linaro.org>
References: <20170725054705.20674-1-bjorn.andersson@linaro.org>
Message-ID: <20170725054705.20674-6-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vivek Gautam <vivek.gautam@codeaurora.org>

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 395666dcce1b..d0865d2f731e 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -496,6 +496,17 @@
 			status = "disabled";
 		};
 
+		qfprom: qfprom at 74000 {
+			compatible = "qcom,qfprom";
+			reg = <0x00074000 0x8ff>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			qusb2p_hstx_trim: hstx_trim at 24e {
+				reg = <0x24e 0x2>;
+				bits = <5 4>;
+			};
+		};
+
 		sdhc2: sdhci at 74a4900 {
 			 status = "disabled";
 			 compatible = "qcom,sdhci-msm-v4";
-- 
2.12.0
