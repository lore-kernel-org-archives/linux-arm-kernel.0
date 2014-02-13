From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 13 Feb 2014 12:04:03 +0200
Subject: [PATCH 5/8] ARM: dts: fix DPLL4 x2 clkouts on 3630
In-Reply-To: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com>
References: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1392285846-13199-6-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP3630 DPLL4 is different than on OMAP3430, in that it doesn't have
the x2 multiplier for its outputs. This is not currently reflected in
the clock DT data.

Fix the issue by setting the clock multiplier to 1 (instead of 2) for the
DPLL4 output clocks.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap36xx-clocks.dtsi | 20 ++++++++++++++++++++
 arch/arm/boot/dts/omap36xx.dtsi        |  2 +-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap36xx-clocks.dtsi b/arch/arm/boot/dts/omap36xx-clocks.dtsi
index 2fcf253b677c..0b2df76b9d38 100644
--- a/arch/arm/boot/dts/omap36xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap36xx-clocks.dtsi
@@ -70,6 +70,26 @@
 	};
 };
 
+&dpll4_m2x2_mul_ck {
+	clock-mult = <1>;
+};
+
+&dpll4_m3x2_mul_ck {
+	clock-mult = <1>;
+};
+
+&dpll4_m4x2_mul_ck {
+	clock-mult = <1>;
+};
+
+&dpll4_m5x2_mul_ck {
+	clock-mult = <1>;
+};
+
+&dpll4_m6x2_mul_ck {
+	clock-mult = <1>;
+};
+
 &cm_clockdomains {
 	dpll4_clkdm: dpll4_clkdm {
 		compatible = "ti,clockdomain";
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index 7e8dee9175d6..5e1bcd06a996 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -52,7 +52,7 @@
 	};
 };
 
-/include/ "omap36xx-clocks.dtsi"
 /include/ "omap34xx-omap36xx-clocks.dtsi"
 /include/ "omap36xx-omap3430es2plus-clocks.dtsi"
 /include/ "omap36xx-am35xx-omap3430es2plus-clocks.dtsi"
+/include/ "omap36xx-clocks.dtsi"
-- 
1.8.3.2
