From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 12 Nov 2016 14:46:43 +0800
Subject: [PATCH 05/10] ARM: dts: sun8i: Add codec analog path controls node in
 PRCM for A23/A33
In-Reply-To: <20161112064648.26779-1-wens@csie.org>
References: <20161112064648.26779-1-wens@csie.org>
Message-ID: <20161112064648.26779-6-wens@csie.org>
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
index 300a1bd5a6ec..ac0d281f4489 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -553,6 +553,10 @@
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
