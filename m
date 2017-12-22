From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 22 Dec 2017 11:29:43 +0100
Subject: [PATCH 05/37] ARM: dts: r8a7790: Correct critical CPU temperature
In-Reply-To: <cover.1513938145.git.horms+renesas@verge.net.au>
References: <cover.1513938145.git.horms+renesas@verge.net.au>
Message-ID: <fcab5651fae4258a993170b7aaf443adbd3d4d84.1513938145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Paterson <chris.paterson2@renesas.com>

The R-Car H2 hardware manual states that Tc = ?40?C to +105?C. The
thermal sensor has an accuracy of ?5?C and there can be a temperature
difference of 1 or 2 degrees between Tjmax and the thermal sensor due
to the location of the latter.

This means that 95?C is a safer value to use.

Fixes: a8b805f3606f7af7 ("ARM: dts: r8a7790: enable to use thermal-zone")
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index e2c530c330a8..606accf5ff2d 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -168,7 +168,7 @@
 
 			trips {
 				cpu-crit {
-					temperature	= <115000>;
+					temperature	= <95000>;
 					hysteresis	= <0>;
 					type		= "critical";
 				};
-- 
2.11.0
