From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Thu, 29 Sep 2016 18:31:51 +0200
Subject: [PATCH 2/6] ARM: dts: da850: add a node for the LCD controller
In-Reply-To: <1475166715-7857-1-git-send-email-bgolaszewski@baylibre.com>
References: <1475166715-7857-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1475166715-7857-3-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Karl Beldan <kbeldan@baylibre.com>

Add a disabled LCDC node to be reused in device trees including
da850.dtsi for boards equipped with tilcdc enabled.

Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
[Bartosz: added the commit description]
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index f79e1b9..9f39296 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -399,6 +399,14 @@
 				<&edma0 0 1>;
 			dma-names = "tx", "rx";
 		};
+
+		lcdc: lcdc at 213000 {
+			compatible = "ti,am33xx-tilcdc";
+			reg = <0x213000 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <52>;
+			status = "disabled";
+		};
 	};
 	aemif: aemif at 68000000 {
 		compatible = "ti,da850-aemif";
-- 
2.7.4
