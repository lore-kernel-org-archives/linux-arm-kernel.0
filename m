From: ivan.ivanov@linaro.org (Ivan T. Ivanov)
Date: Thu,  4 Jun 2015 12:19:02 +0300
Subject: [PATCH 3/7] arm64: dts: qcom: Add msm8916 sdhci configuration nodes
In-Reply-To: <1433409546-23995-1-git-send-email-ivan.ivanov@linaro.org>
References: <1433409546-23995-1-git-send-email-ivan.ivanov@linaro.org>
Message-ID: <1433409546-23995-4-git-send-email-ivan.ivanov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Add sdhci1 and sdhci2 device configuration nodes.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 6681c65..9ff0eb4 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -24,7 +24,10 @@
 	#address-cells = <2>;
 	#size-cells = <2>;

-	aliases { };
+	aliases {
+		sdhc1 = &sdhc_1; /* SDC1 eMMC slot */
+		sdhc2 = &sdhc_2; /* SDC2 SD card slot */
+	};

 	chosen { };

@@ -236,6 +239,35 @@
 			status = "disabled";
 		};

+		sdhc_1: sdhci at 07824000 {
+			compatible = "qcom,sdhci-msm-v4";
+			reg = <0x07824900 0x11c>, <0x07824000 0x800>;
+			reg-names = "hc_mem", "core_mem";
+
+			interrupts = <0 123 0>, <0 138 0>;
+			interrupt-names = "hc_irq", "pwr_irq";
+			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
+				 <&gcc GCC_SDCC1_AHB_CLK>;
+			clock-names = "core", "iface";
+			bus-width = <8>;
+			non-removable;
+			status = "disabled";
+		};
+
+		sdhc_2: sdhci at 07864000 {
+			compatible = "qcom,sdhci-msm-v4";
+			reg = <0x07864900 0x11c>, <0x07864000 0x800>;
+			reg-names = "hc_mem", "core_mem";
+
+			interrupts = <0 125 0>, <0 221 0>;
+			interrupt-names = "hc_irq", "pwr_irq";
+			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
+				 <&gcc GCC_SDCC2_AHB_CLK>;
+			clock-names = "core", "iface";
+			bus-width = <4>;
+			status = "disabled";
+		};
+
 		intc: interrupt-controller at b000000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
--
1.9.1
