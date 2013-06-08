From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  8 Jun 2013 18:39:36 +0400
Subject: [PATCH 1/5] ARM: dts: i.MX27: Add DMA devicetree node
Message-ID: <1370702380-25408-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the missing DMA devicetree node for i.MX27 SoCs.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 7017bfe..9d65734 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -61,6 +61,16 @@
 			reg = <0x10000000 0x20000>;
 			ranges;
 
+			dma: dma at 10001000 {
+				compatible = "fsl,imx27-dma";
+				reg = <0x10001000 0x1000>;
+				interrupts = <32>;
+				clocks = <&clks 50>, <&clks 70>;
+				clock-names = "ipg", "ahb";
+				#dma-cells = <1>;
+				#dma-channels = <16>;
+			};
+
 			wdog: wdog at 10002000 {
 				compatible = "fsl,imx27-wdt", "fsl,imx21-wdt";
 				reg = <0x10002000 0x1000>;
-- 
1.8.1.5
