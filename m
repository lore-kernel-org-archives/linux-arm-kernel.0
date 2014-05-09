From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 9 May 2014 14:56:10 +0300
Subject: [PATCH 02/11] ARM: dts: am43xx: add ti,set-rate-parent for disp_clk
In-Reply-To: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com>
References: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1399636579-8062-3-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sathya Prakash M R <sathyap@ti.com>

disp_clk is a mux-clock, and to set the rate of the parent PLL, we need
ti,set-rate-parent flag.

Add the flag.

Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/am43xx-clocks.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
index 142009cc9332..144663ba7739 100644
--- a/arch/arm/boot/dts/am43xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
@@ -511,6 +511,7 @@
 		compatible = "ti,mux-clock";
 		clocks = <&dpll_disp_m2_ck>, <&dpll_core_m5_ck>, <&dpll_per_m2_ck>;
 		reg = <0x4244>;
+		ti,set-rate-parent;
 	};
 
 	dpll_extdev_ck: dpll_extdev_ck {
-- 
1.9.1
