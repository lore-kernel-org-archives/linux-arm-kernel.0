From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  9 Feb 2017 17:39:15 +0100
Subject: [PATCH 1/8] ARM: sun8i: Fix the mali clock rate
In-Reply-To: <cover.7101c7323e6f22e281ad70b93488cf44caca4ca0.1486655917.git-series.maxime.ripard@free-electrons.com>
References: <cover.7101c7323e6f22e281ad70b93488cf44caca4ca0.1486655917.git-series.maxime.ripard@free-electrons.com>
Message-ID: <4830ced34cc83058f7cad123be67fecc624a99d6.1486655917.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Mali clock rate was improperly assumed to be 408MHz, while it was
really 384Mhz, 408MHz being the "extreme" frequency, and definitely not
stable.

Switch for the stable, correct frequency for the GPU.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 35008b78d899..8a880ecc4dda 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -495,7 +495,7 @@
 			resets = <&ccu RST_BUS_GPU>;
 
 			assigned-clocks = <&ccu CLK_GPU>;
-			assigned-clock-rates = <408000000>;
+			assigned-clock-rates = <384000000>;
 		};
 
 		gic: interrupt-controller at 01c81000 {
-- 
git-series 0.8.11
