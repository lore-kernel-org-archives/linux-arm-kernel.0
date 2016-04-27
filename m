From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 28 Apr 2016 09:08:09 +1000
Subject: [PATCH 2/5] ARM: dts: r8a7779: Don't disable referenced optional
 clocks
In-Reply-To: <cover.1461798352.git.horms+renesas@verge.net.au>
References: <cover.1461798352.git.horms+renesas@verge.net.au>
Message-ID: <55ee434728ebf0a0087bbe749d6be7d7170a514c.1461798352.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

clk_get() on a disabled clock node will return -EPROBE_DEFER, which can
cause drivers to be deferred forever if such clocks are referenced in
their devices' clocks properties.

Update the various disabled external clock nodes to default to a
frequency of 0, but don't disable them, to prevent this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 5c1d48d712a1..0c82097daffc 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -458,7 +458,6 @@
 			#clock-cells = <0>;
 			/* This value must be overridden by the board. */
 			clock-frequency = <0>;
-			status = "disabled";
 		};
 
 		/* Special CPG clocks */
-- 
2.7.0.rc3.207.g0ac5344
