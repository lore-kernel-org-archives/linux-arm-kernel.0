From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Tue,  9 Apr 2013 10:48:04 -0300
Subject: [PATCH 3/3] ARM: sunxi: unify osc24M_fixed and osc24M
In-Reply-To: <1365515284-32061-1-git-send-email-emilio@elopez.com.ar>
References: <1365515284-32061-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1365515284-32061-4-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the clock driver supports the gatable oscillator as one single
clock, drop osc24M_fixed and move the relevant properties to osc24M

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 arch/arm/boot/dts/sunxi.dtsi | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi.dtsi b/arch/arm/boot/dts/sunxi.dtsi
index a8d47e2..2309272 100644
--- a/arch/arm/boot/dts/sunxi.dtsi
+++ b/arch/arm/boot/dts/sunxi.dtsi
@@ -39,17 +39,11 @@
 			clock-frequency = <0>;
 		};
 
-		osc24M_fixed: osc24M_fixed {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <24000000>;
-		};
-
 		osc24M: osc24M at 01c20050 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-osc-clk";
+			clock-frequency = <24000000>;
 			reg = <0x01c20050 0x4>;
-			clocks = <&osc24M_fixed>;
 		};
 
 		osc32k: osc32k {
-- 
1.8.2.1
