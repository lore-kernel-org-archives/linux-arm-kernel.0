From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 27 Sep 2014 16:49:55 +0800
Subject: [PATCH v2 7/7] ARM: dts: sun6i: Add required ahb1 clock parent and
 rates for dma controller
In-Reply-To: <1411807795-6575-1-git-send-email-wens@csie.org>
References: <1411807795-6575-1-git-send-email-wens@csie.org>
Message-ID: <1411807795-6575-8-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DMA controller requires AHB1 bus clock to be clocked from PLL6.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index caf879d..d7845d3 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -353,6 +353,11 @@
 			clocks = <&ahb1_gates 6>;
 			resets = <&ahb1_rst 6>;
 			#dma-cells = <1>;
+
+			/* DMA controller requires AHB1 clocked from PLL6 */
+			assigned-clocks = <&ahb1>;
+			assigned-clock-parents = <&pll6 0>;
+			assigned-clock-rates = <200000000>;
 		};
 
 		mmc0: mmc at 01c0f000 {
-- 
2.1.1
