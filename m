From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 21 Jun 2016 18:39:53 +0100
Subject: [PATCH v2 16/16] arm64: dts: msm8996: add sdc2 support
In-Reply-To: <1466176454-28084-18-git-send-email-srinivas.kandagatla@linaro.org>
References: <1466176454-28084-18-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1466530793-4534-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to sdc2 sdhci controller, which is used on some
of the boards.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Hi Andy, 

Am resending just this one patch, as It does not make sense
to resend entire series for such a small change.

changes since v1:
	- converted sdhci address from caps to small.

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index f68b078..55ec3e8 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -246,6 +246,21 @@
 			status = "disabled";
 		};
 
+		sdhc2: sdhci at 74a4900 {
+			 status = "disabled";
+			 compatible = "qcom,sdhci-msm-v4";
+			 reg = <0x74a4900 0x314>, <0x74a4000 0x800>;
+			 reg-names = "hc_mem", "core_mem";
+
+			 interrupts = <0 125 0>, <0 221 0>;
+			 interrupt-names = "hc_irq", "pwr_irq";
+
+			 clock-names = "iface", "core";
+			 clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+			 <&gcc GCC_SDCC2_APPS_CLK>;
+			 bus-width = <4>;
+		 };
+
 		msmgpio: pinctrl at 1010000 {
 			compatible = "qcom,msm8996-pinctrl";
 			reg = <0x01010000 0x300000>;
-- 
2.7.4
