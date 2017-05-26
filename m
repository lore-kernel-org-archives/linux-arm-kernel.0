From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 26 May 2017 16:00:23 +0800
Subject: [PATCH 1/3] dt-bindings: clock: sunxi-ccu: Add compatible string for
 A83T PRCM
In-Reply-To: <20170526080025.28532-1-wens@csie.org>
References: <20170526080025.28532-1-wens@csie.org>
Message-ID: <20170526080025.28532-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A83T's PRCM has the same set of clocks and resets as the A64.
However, a few dividers are different. And due to the lack of a low
speed 32.768 kHz oscillator, a few of the clock parents are different.

The PRCM also has controls for various power domains. These are not
supported yet.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
index 34b2a9249a94..095a5807d874 100644
--- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
@@ -7,6 +7,7 @@ Required properties :
 		- "allwinner,sun8i-a23-ccu"
 		- "allwinner,sun8i-a33-ccu"
 		- "allwinner,sun8i-a83t-ccu"
+		- "allwinner,sun8i-a83t-r-ccu"
 		- "allwinner,sun8i-h3-ccu"
 		- "allwinner,sun8i-h3-r-ccu"
 		- "allwinner,sun8i-v3s-ccu"
@@ -24,7 +25,7 @@ Required properties :
 - #clock-cells : must contain 1
 - #reset-cells : must contain 1
 
-For the PRCM CCUs on H3/A64, one more clock is needed:
+For the PRCM CCUs on A83T/H3/A64, one more clock is needed:
 - "iosc": the SoC's internal frequency oscillator
 
 Example for generic CCU:
-- 
2.11.0
