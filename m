From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 22 Nov 2016 10:42:55 +0100
Subject: [PATCH] ARM: dts: da850: specify max width for display node
Message-ID: <1479807775-28283-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It has been determined that the highest resolution supported correctly
by LCDC rev1 is 800x600 on da850 due to memory bandwidth constraints.

Set the max_width property in da850.dtsi to 800.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 36066fa..0876238 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -441,6 +441,7 @@
 			compatible = "ti,da850-tilcdc";
 			reg = <0x213000 0x1000>;
 			interrupts = <52>;
+			max-width = <800>;
 			status = "disabled";
 		};
 	};
-- 
2.9.3
