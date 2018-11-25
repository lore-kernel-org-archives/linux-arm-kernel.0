From: otavio@ossystems.com.br (Otavio Salvador)
Date: Sun, 25 Nov 2018 19:19:03 -0200
Subject: [PATCH 09/13] ARM: dts: rv1108: Assign the proper GPIO clocks
In-Reply-To: <20181125211907.9895-1-otavio@ossystems.com.br>
References: <20181125211907.9895-1-otavio@ossystems.com.br>
Message-ID: <20181125211907.9895-9-otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is not correct to assign the 24MHz clock oscillator to the GPIO
ports.

Fix it by assigning the proper GPIO clocks instead.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
Signed-off-by: Fabio Berton <fabio.berton@ossystems.com.br>
---

 arch/arm/boot/dts/rv1108.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 442b749eb2e9..ce5509c4657b 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -562,7 +562,7 @@
 			compatible = "rockchip,gpio-bank";
 			reg = <0x20030000 0x100>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&xin24m>;
+			clocks = <&cru PCLK_GPIO0_PMU>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -575,7 +575,7 @@
 			compatible = "rockchip,gpio-bank";
 			reg = <0x10310000 0x100>;
 			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&xin24m>;
+			clocks = <&cru PCLK_GPIO1>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -588,7 +588,7 @@
 			compatible = "rockchip,gpio-bank";
 			reg = <0x10320000 0x100>;
 			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&xin24m>;
+			clocks = <&cru PCLK_GPIO2>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -601,7 +601,7 @@
 			compatible = "rockchip,gpio-bank";
 			reg = <0x10330000 0x100>;
 			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&xin24m>;
+			clocks = <&cru PCLK_GPIO3>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
-- 
2.19.1
