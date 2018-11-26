From: otavio@ossystems.com.br (Otavio Salvador)
Date: Mon, 26 Nov 2018 15:35:04 -0200
Subject: [PATCH v2 2/4] ARM: dts: rockchip: Assign the proper GPIO clocks for
 rv1108
In-Reply-To: <20181126173506.24068-1-otavio@ossystems.com.br>
References: <20181126173506.24068-1-otavio@ossystems.com.br>
Message-ID: <20181126173506.24068-2-otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is not correct to assign the 24MHz clock oscillator to the GPIO
ports.

Fix it by assigning the proper GPIO clocks instead.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
Tested-by: Fabio Berton <fabio.berton@ossystems.com.br>
---

Changes in v2:
- fixup commit signed-off-by
- fixup commit log

 arch/arm/boot/dts/rv1108.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 611f2fe8e56c..300de8e1475b 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -565,7 +565,7 @@
 			compatible = "rockchip,gpio-bank";
 			reg = <0x20030000 0x100>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&xin24m>;
+			clocks = <&cru PCLK_GPIO0_PMU>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -578,7 +578,7 @@
 			compatible = "rockchip,gpio-bank";
 			reg = <0x10310000 0x100>;
 			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&xin24m>;
+			clocks = <&cru PCLK_GPIO1>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -591,7 +591,7 @@
 			compatible = "rockchip,gpio-bank";
 			reg = <0x10320000 0x100>;
 			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&xin24m>;
+			clocks = <&cru PCLK_GPIO2>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -604,7 +604,7 @@
 			compatible = "rockchip,gpio-bank";
 			reg = <0x10330000 0x100>;
 			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&xin24m>;
+			clocks = <&cru PCLK_GPIO3>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
-- 
2.19.2
