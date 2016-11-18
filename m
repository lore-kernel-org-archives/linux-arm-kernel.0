From: robertcnelson@gmail.com (Robert Nelson)
Date: Thu, 17 Nov 2016 20:44:34 -0600
Subject: [RFC 4/6] ARM: dts: dra7: add entry for bb2d module
In-Reply-To: <20161118024436.13447-1-robertcnelson@gmail.com>
References: <20161118024436.13447-1-robertcnelson@gmail.com>
Message-ID: <20161118024436.13447-4-robertcnelson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gowtham Tammana <g-tammana@ti.com>

BB2D entry is added to the dts file. Crossbar index number is used
for interrupt mapping.

Signed-off-by: Gowtham Tammana <g-tammana@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index addb753..43488b6 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -959,6 +959,16 @@
 			ti,hwmods = "dmm";
 		};
 
+		bb2d: bb2d at 59000000 {
+			compatible = "ti,dra7-bb2d";
+			reg = <0x59000000 0x0700>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "bb2d";
+			clocks = <&dpll_core_h24x2_ck>;
+			clock-names = "fclk";
+			status = "disabled";
+		};
+
 		i2c1: i2c at 48070000 {
 			compatible = "ti,omap4-i2c";
 			reg = <0x48070000 0x100>;
-- 
2.10.2
