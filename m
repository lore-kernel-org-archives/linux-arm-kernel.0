From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Sun, 18 Feb 2018 03:54:42 +0800
Subject: [PATCH v3 07/15] arm64: dts: mt7622: turn uart0 clock to real ones
In-Reply-To: <cover.1518895232.git.sean.wang@mediatek.com>
References: <cover.1518895232.git.sean.wang@mediatek.com>
Message-ID: <adc8e8585824abbd571e9c1a32db7b2cb084995b.1518895232.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

This patch also cleans up two oscillators that provide clocks for MT7623.
Switch the uart clocks to the real ones while at it.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 7256879..d8a17d1 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -91,18 +91,6 @@
 		};
 	};
 
-	uart_clk: dummy25m {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <25000000>;
-	};
-
-	bus_clk: dummy280m {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <280000000>;
-	};
-
 	pwrap_clk: dummy40m {
 		compatible = "fixed-clock";
 		clock-frequency = <40000000>;
@@ -234,7 +222,8 @@
 			     "mediatek,mt6577-uart";
 		reg = <0 0x11002000 0 0x400>;
 		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&uart_clk>, <&bus_clk>;
+		clocks = <&topckgen CLK_TOP_UART_SEL>,
+			 <&pericfg CLK_PERI_UART1_PD>;
 		clock-names = "baud", "bus";
 		status = "disabled";
 	};
-- 
2.7.4
