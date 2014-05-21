From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 21 May 2014 15:16:11 +0300
Subject: [PATCH 2/2] ARM: dts: am43xx-clocks.dtsi: add ti,
 set-rate-parent to display clock path
In-Reply-To: <1400674571-633-1-git-send-email-tomi.valkeinen@ti.com>
References: <1400674571-633-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1400674571-633-2-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need set-rate-parent flags for the display's clock path so that the
DSS driver can change the clock rate of the PLL.

This patchs adds the ti,set-rate-parent flag to disp_clk and
dpll_disp_m2_ck clock nodes.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/am43xx-clocks.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
index 142009cc9332..a6f7ee74990f 100644
--- a/arch/arm/boot/dts/am43xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
@@ -229,6 +229,7 @@
 		reg = <0x2e30>;
 		ti,index-starts-at-one;
 		ti,invert-autoidle-bit;
+		ti,set-rate-parent;
 	};
 
 	dpll_per_ck: dpll_per_ck {
@@ -511,6 +512,7 @@
 		compatible = "ti,mux-clock";
 		clocks = <&dpll_disp_m2_ck>, <&dpll_core_m5_ck>, <&dpll_per_m2_ck>;
 		reg = <0x4244>;
+		ti,set-rate-parent;
 	};
 
 	dpll_extdev_ck: dpll_extdev_ck {
-- 
1.9.1
