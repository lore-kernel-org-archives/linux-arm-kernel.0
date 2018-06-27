From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Wed, 27 Jun 2018 09:26:35 +0200
Subject: [PATCH] ARM: dts: sun8i-h3: Increase the GPU clock to 576 MHz
Message-ID: <20180627072635.3592-1-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It was reported (based on declarations from the Allwiner BSP) that the
Mali 400 found on the H3 can be clocked up to 576 MHz.

The frequency was tested using the r6p2 out-of-tree driver and a Kodi
userspace with associated r6p2 blobs, leading to a working result.

This increases the clock to 576 MHz, which directly increases the pixel
throughput of the GPU (given the 1 pixel-per-cycle rate).

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 41d57c76f290..a14a63092dc6 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -133,7 +133,7 @@
 			resets = <&ccu RST_BUS_GPU>;
 
 			assigned-clocks = <&ccu CLK_GPU>;
-			assigned-clock-rates = <384000000>;
+			assigned-clock-rates = <576000000>;
 		};
 	};
 };
-- 
2.17.1
