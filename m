From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 25 Nov 2016 20:34:37 +0800
Subject: [PATCH v2 3/8] ARM: dts: sun8i: Add codec analog path controls node
 in PRCM for A23/A33
In-Reply-To: <20161125123442.28410-1-wens@csie.org>
References: <20161125123442.28410-1-wens@csie.org>
Message-ID: <20161125123442.28410-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the A23/A33, the internal codec's analog path controls are located in
the PRCM node.

Add a sub-device node to the PRCM for it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index bc3e936edfcf..d9c6f16f95f1 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -538,6 +538,10 @@
 				compatible = "allwinner,sun6i-a31-clock-reset";
 				#reset-cells = <1>;
 			};
+
+			codec_analog: codec-analog {
+				compatible = "allwinner,sun8i-a23-codec-analog";
+			};
 		};
 
 		cpucfg at 01f01c00 {
-- 
2.10.2
