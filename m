From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 21 Apr 2014 12:41:47 +0200
Subject: [PATCH 2/2] ARM: dts: set 'ti,set-rate-parent' for dpll4_m5 path
In-Reply-To: <1398076907-2901-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1398076907-2901-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1398076907-2901-3-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set 'ti,set-rate-parent' property for the dpll4_m5x2_mul_ck clock, which
is used for the ISP functional clock. This fixes the OMAP3 ISP driver's
clock rate configuration, which needs the rate to be propagated properly
to the divider node (dpll4_m5_ck).

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/omap3xxx-clocks.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap3xxx-clocks.dtsi b/arch/arm/boot/dts/omap3xxx-clocks.dtsi
index 351f58b..e47ff69 100644
--- a/arch/arm/boot/dts/omap3xxx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap3xxx-clocks.dtsi
@@ -457,6 +457,7 @@
 		clocks = <&dpll4_m5_ck>;
 		ti,clock-mult = <2>;
 		ti,clock-div = <1>;
+		ti,set-rate-parent;
 	};
 
 	dpll4_m5x2_ck: dpll4_m5x2_ck {
-- 
1.8.3.2
