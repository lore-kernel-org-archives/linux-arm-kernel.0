From: shc_work@mail.ru (Alexander Shiyan)
Date: Fri,  3 May 2013 15:16:09 +0400
Subject: [PATCH 2/2] ARM: dts: Add DMA support to imx27 device tree
In-Reply-To: <1367579769-22958-1-git-send-email-shc_work@mail.ru>
References: <1367579769-22958-1-git-send-email-shc_work@mail.ru>
Message-ID: <1367579769-22958-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index cd85828..943e8f3 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -61,6 +61,14 @@
 			reg = <0x10000000 0x20000>;
 			ranges;
 
+			dma: dma at 10001000 {
+				compatible = "fsl,imx27-dma";
+				reg = <0x10001000 0x1000>;
+				interrupts = <32>;
+				clocks = <&clks 50>, <&clks 70>;
+				clock-names = "ipg", "ahb";
+			};
+
 			wdog: wdog at 10002000 {
 				compatible = "fsl,imx27-wdt", "fsl,imx21-wdt";
 				reg = <0x10002000 0x1000>;
-- 
1.8.1.5
