From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 Sep 2017 15:46:13 -0700
Subject: [PATCH 02/10] ARM: dts: omap4: add fck under timer1
In-Reply-To: <20170920224621.16236-1-tony@atomide.com>
References: <20170920224621.16236-1-tony@atomide.com>
Message-ID: <20170920224621.16236-3-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tero Kristo <t-kristo@ti.com>

Add the functional clock definition for timer1. This is needed so that
the clock rate calculations continue to function properly once omap4
transitions away from hwmod data and towards the clkctrl clocks.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -854,6 +854,8 @@
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer1";
 			ti,timer-alwon;
+			clocks = <&dmt1_clk_mux>;
+			clock-names = "fck";
 		};
 
 		timer2: timer at 48032000 {
-- 
2.14.1
