From: wens@csie.org (Chen-Yu Tsai)
Date: Sat,  6 Sep 2014 18:47:27 +0800
Subject: [PATCH 6/7] ARM: dts: sun6i: Add required ahb1 clock parent and rates
 for dma controller
In-Reply-To: <1410000448-9999-1-git-send-email-wens@csie.org>
References: <1410000448-9999-1-git-send-email-wens@csie.org>
Message-ID: <1410000448-9999-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DMA controller requires AHB1 bus clock to be clocked from PLL6.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 8eb2c6d..1117989 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -317,6 +317,11 @@
 			clocks = <&ahb1_gates 6>;
 			resets = <&ahb1_rst 6>;
 			#dma-cells = <1>;
+
+			/* DMA controller requires AHB1 clocked from PLL6 */
+			assigned-clocks = <&ahb1>;
+			assigned-clock-parents = <&pll6>;
+			assigned-clock-rates = <200000000>;
 		};
 
 		mmc0: mmc at 01c0f000 {
-- 
2.1.0
