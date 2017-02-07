From: eric@anholt.net (Eric Anholt)
Date: Tue,  7 Feb 2017 13:07:03 -0800
Subject: [PATCH 3/3] ARM: dts: bcm283x: Add HDMI audio related properties
In-Reply-To: <20170207210703.7082-1-eric@anholt.net>
References: <20170207210703.7082-1-eric@anholt.net>
Message-ID: <20170207210703.7082-3-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris Brezillon <boris.brezillon@free-electrons.com>

Add the dmas and dma-names properties to support HDMI audio.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm283x.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 9a44da190897..48a055d3f25e 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -491,6 +491,8 @@
 			clocks = <&clocks BCM2835_PLLH_PIX>,
 				 <&clocks BCM2835_CLOCK_HSM>;
 			clock-names = "pixel", "hdmi";
+			dmas = <&dma 17>;
+			dma-names = "audio-rx";
 			status = "disabled";
 		};
 
-- 
2.11.0
