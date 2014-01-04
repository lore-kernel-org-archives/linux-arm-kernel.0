From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  4 Jan 2014 22:28:35 +0400
Subject: [PATCH] ARM: dts: i.MX27: Add SSI nodes
Message-ID: <1388860115-18848-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the missing (Synchronous Serial Interface) SSI1 & SSI2
devicetree nodes for i.MX27 CPUs.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 63b1b32..7e98966 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -207,6 +207,30 @@
 				status = "disabled";
 			};
 
+			ssi1: ssi at 10010000 {
+				#sound-dai-cells = <0>;
+				compatible = "fsl,imx27-ssi", "fsl,imx21-ssi";
+				reg = <0x10010000 0x1000>;
+				interrupts = <14>;
+				clocks = <&clks 26>;
+				dmas = <&dma 12>, <&dma 13>, <&dma 14>, <&dma 15>;
+				dma-names = "rx0", "tx0", "rx1", "tx1";
+				fsl,fifo-depth = <8>;
+				status = "disabled";
+			};
+
+			ssi2: ssi at 10011000 {
+				#sound-dai-cells = <0>;
+				compatible = "fsl,imx27-ssi", "fsl,imx21-ssi";
+				reg = <0x10011000 0x1000>;
+				interrupts = <13>;
+				clocks = <&clks 25>;
+				dmas = <&dma 8>, <&dma 9>, <&dma 10>, <&dma 11>;
+				dma-names = "rx0", "tx0", "rx1", "tx1";
+				fsl,fifo-depth = <8>;
+				status = "disabled";
+			};
+
 			i2c1: i2c at 10012000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
1.8.3.2
