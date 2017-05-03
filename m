From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  3 May 2017 11:16:51 +0800
Subject: [PATCH v2 1/8] dt-bindings: clock: sunxi-ccu: Add compatible string
 for A83T CCU
In-Reply-To: <20170503031658.29299-1-wens@csie.org>
References: <20170503031658.29299-1-wens@csie.org>
Message-ID: <20170503031658.29299-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A83T clock control unit is a hybrid of some new style clock designs
from the A80, and old style layout from the other Allwinner SoCs.

Like the A80, the SoC does not have a low speed 32.768 kHz oscillator.
Unlike the A80, there is no clock input either. The only low speed clock
available is the internal oscillator which runs at around 16 MHz,
divided by 512, yielding a low speed clock around 31.250 kHz.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
index e9c5a1d9834a..34b2a9249a94 100644
--- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
@@ -6,6 +6,7 @@ Required properties :
 		- "allwinner,sun6i-a31-ccu"
 		- "allwinner,sun8i-a23-ccu"
 		- "allwinner,sun8i-a33-ccu"
+		- "allwinner,sun8i-a83t-ccu"
 		- "allwinner,sun8i-h3-ccu"
 		- "allwinner,sun8i-h3-r-ccu"
 		- "allwinner,sun8i-v3s-ccu"
@@ -18,6 +19,7 @@ Required properties :
 - clocks: phandle to the oscillators feeding the CCU. Two are needed:
   - "hosc": the high frequency oscillator (usually at 24MHz)
   - "losc": the low frequency oscillator (usually at 32kHz)
+	    On the A83T, this is the internal 16MHz oscillator divided by 512
 - clock-names: Must contain the clock names described just above
 - #clock-cells : must contain 1
 - #reset-cells : must contain 1
-- 
2.11.0
