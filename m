From: ssambang@codeaurora.org (Sreedhar Sambangi)
Date: Tue,  5 Apr 2016 00:54:02 -0700
Subject: [PATCH] qcom: ipq4019: Add SDHC device nodes for SOC and DK04 board.
Message-ID: <1459842842-8409-1-git-send-email-ssambang@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Support for SDHC Controller on the IPQ4019 SOC.

Signed-off-by: Sreedhar Sambangi <ssambang@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi |  7 +++++++
 arch/arm/boot/dts/qcom-ipq4019.dtsi           | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
index 566e239..c8d4dbc 100644
--- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
@@ -88,6 +88,7 @@
 					bias-disable = <0>;
 				};*/
 			};
+
 		};
 
 		blsp_dma: dma at 7884000 {
@@ -166,5 +167,11 @@
 			reg = <0x01948000 0x4>;
 			mask = <0x3>;
 		};
+
+		sdhci at 7824000 {
+			status = "ok";
+			vqmmc-supply = <&vccq_sd0>;
+			non-removable;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 9a3cd26..d70e503 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -363,5 +363,15 @@
 			compatible = "qcom,pshold";
 			reg = <0x4ab000 0x4>;
 		};
+
+		sdhci at 7824000 {
+			compatible = "qcom,sdhci-msm-v4";
+			reg = <0x7824900 0x11c>, <0x7824000 0x800>;
+			interrupts = <0 123 0>, <0 138 0>;
+			bus-width = <8>;
+			clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
 	};
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
