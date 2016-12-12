From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 12 Dec 2016 14:05:42 +0100
Subject: [PATCH v6 5/5] ARM: dts: da850: specify the maximum pixel clock rate
 for tilcdc
In-Reply-To: <1481547942-24775-1-git-send-email-bgolaszewski@baylibre.com>
References: <1481547942-24775-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1481547942-24775-6-git-send-email-bgolaszewski@baylibre.com>
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
index 3f51e59..ba5bf80 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -452,6 +452,7 @@
 			compatible = "ti,da850-tilcdc";
 			reg = <0x213000 0x1000>;
 			interrupts = <52>;
+			max-pixelclock = <37500>;
 			status = "disabled";
 		};
 	};
-- 
2.9.3
