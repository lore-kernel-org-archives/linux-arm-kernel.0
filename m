From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 18 Sep 2015 15:35:36 +0800
Subject: [PATCH 1/4] ARM: dts: sun8i: Add PWM controller node for A23/A33
In-Reply-To: <1442561739-6824-1-git-send-email-wens@csie.org>
References: <1442561739-6824-1-git-send-email-wens@csie.org>
Message-ID: <1442561739-6824-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A23/A33 have a PWM controller that is compatible to the one on the A20.
Add a device node for it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 27a925ec17d2..e7054304018a 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -466,6 +466,14 @@
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pwm: pwm at 01c21400 {
+			compatible = "allwinner,sun7i-a20-pwm";
+			reg = <0x01c21400 0xc>;
+			clocks = <&osc24M>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		lradc: lradc at 01c22800 {
 			compatible = "allwinner,sun4i-a10-lradc-keys";
 			reg = <0x01c22800 0x100>;
-- 
2.5.1
