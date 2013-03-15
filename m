From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 15 Mar 2013 21:06:25 +0100
Subject: [PATCH 3/6] ARM: sunxi: dt: Move uart0 to sun4i-a10.dtsi
In-Reply-To: <1363377988-4966-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1363377988-4966-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1363377988-4966-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UART0 is only available on the Allwinner A10 SoCs, and not on the
A13, so move the uart0 node to sun4i-a10.dtsi.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Emilio L?pez <emilio@elopez.com.ar>
Tested-by: Emilio L?pez <emilio@elopez.com.ar>
---
 arch/arm/boot/dts/sun4i-a10.dtsi |   10 ++++++++++
 arch/arm/boot/dts/sunxi.dtsi     |   10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 03d2b53..703e7cb 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -47,5 +47,15 @@
 				allwinner,pull = <0>;
 			};
 		};
+
+		uart0: uart at 01c28000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c28000 0x400>;
+			interrupts = <1>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&osc>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/sunxi.dtsi b/arch/arm/boot/dts/sunxi.dtsi
index 791c02a..4f78ef7 100644
--- a/arch/arm/boot/dts/sunxi.dtsi
+++ b/arch/arm/boot/dts/sunxi.dtsi
@@ -59,16 +59,6 @@
 			#interrupt-cells = <1>;
 		};
 
-		uart0: uart at 01c28000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x01c28000 0x400>;
-			interrupts = <1>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clocks = <&osc>;
-			status = "disabled";
-		};
-
 		uart1: uart at 01c28400 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28400 0x400>;
-- 
1.7.10.4
