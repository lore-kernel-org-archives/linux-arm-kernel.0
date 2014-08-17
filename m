From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 17 Aug 2014 11:52:11 +0800
Subject: [PATCH 05/12] ARM: dts: sun8i: ippo-q8h: Add pinctrl properties for
 R_UART
In-Reply-To: <1408247538-16950-1-git-send-email-wens@csie.org>
References: <1408247538-16950-1-git-send-email-wens@csie.org>
Message-ID: <1408247538-16950-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have R_PIO controller support and the pinmux for R_UART,
add the correct pinctrl properties to the R_UART node.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
index 34002e3..224f53e 100644
--- a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
+++ b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
@@ -24,6 +24,8 @@
 
 	soc at 01c00000 {
 		r_uart: serial at 01f02800 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_uart_pins_a>;
 			status = "okay";
 		};
 	};
-- 
2.1.0
