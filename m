From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  8 Jun 2013 18:39:37 +0400
Subject: [PATCH 2/5] ARM: dts: i.MX27: Add SDHC devicetree nodes
In-Reply-To: <1370702380-25408-1-git-send-email-shc_work@mail.ru>
References: <1370702380-25408-1-git-send-email-shc_work@mail.ru>
Message-ID: <1370702380-25408-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the missing SDHC devicetree nodes for i.MX27 SoCs.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 9d65734..587f10c 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -178,6 +178,28 @@
 				status = "disabled";
 			};
 
+			sdhci1: sdhci at 10013000 {
+				compatible = "fsl,imx27-mmc", "fsl,imx21-mmc";
+				reg = <0x10013000 0x1000>;
+				interrupts = <11>;
+				clocks = <&clks 30>, <&clks 60>;
+				clock-names = "ipg", "per";
+				dmas = <&dma 7>;
+				dma-names = "rx-tx";
+				status = "disabled";
+			};
+
+			sdhci2: sdhci at 10014000 {
+				compatible = "fsl,imx27-mmc", "fsl,imx21-mmc";
+				reg = <0x10014000 0x1000>;
+				interrupts = <10>;
+				clocks = <&clks 29>, <&clks 60>;
+				clock-names = "ipg", "per";
+				dmas = <&dma 6>;
+				dma-names = "rx-tx";
+				status = "disabled";
+			};
+
 			gpio1: gpio at 10015000 {
 				compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
 				reg = <0x10015000 0x100>;
@@ -293,6 +315,17 @@
 				status = "disabled";
 			};
 
+			sdhci3: sdhci at 1001e000 {
+				compatible = "fsl,imx27-mmc", "fsl,imx21-mmc";
+				reg = <0x1001e000 0x1000>;
+				interrupts = <9>;
+				clocks = <&clks 28>, <&clks 60>;
+				clock-names = "ipg", "per";
+				dmas = <&dma 36>;
+				dma-names = "rx-tx";
+				status = "disabled";
+			};
+
 			gpt6: timer at 1001f000 {
 				compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
 				reg = <0x1001f000 0x1000>;
-- 
1.8.1.5
