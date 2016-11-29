From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 29 Nov 2016 12:57:04 +0100
Subject: [PATCH v3 2/2] ARM: dts: da850: specify the maximum pixel clock rate
 for tilcdc
In-Reply-To: <1480420624-23544-1-git-send-email-bgolaszewski@baylibre.com>
References: <1480420624-23544-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1480420624-23544-3-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At maximum CPU frequency of 300 MHz the maximum pixel clock frequency
is 37.5 MHz[1]. We must filter out any mode for which the calculated
pixel clock rate would exceed this value.

Specify the max-pixelclock property for the display node for
da850-lcdk.

[1] http://processors.wiki.ti.com/index.php/OMAP-L1x/C674x/AM1x_LCD_Controller_(LCDC)_Throughput_and_Optimization_Techniques

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 5f4ba2e..00692d3 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -453,6 +453,7 @@
 			compatible = "ti,da850-tilcdc";
 			reg = <0x213000 0x1000>;
 			interrupts = <52>;
+			max-pixelclock = <37500>;
 			status = "disabled";
 
 			ports {
-- 
2.9.3
