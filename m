From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Fri,  6 Jul 2018 19:50:59 +0200
Subject: [PATCH 03/17] ARM: dts: sun8i: r40: Remove fallback display engine
 compatible
In-Reply-To: <20180706175113.26698-1-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
Message-ID: <20180706175113.26698-4-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R40 has pretty unique display pipeline. Because of that, H3 display
engine compatible fallback should be removed.

Fixes: 05a43a262d03 ("ARM: dts: sun8i: r40: Add HDMI pipeline")

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index c95a59aac48f..2afb079a3776 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -102,8 +102,7 @@
 	};
 
 	de: display-engine {
-		compatible = "allwinner,sun8i-r40-display-engine",
-			     "allwinner,sun8i-h3-display-engine";
+		compatible = "allwinner,sun8i-r40-display-engine";
 		allwinner,pipelines = <&mixer0>, <&mixer1>;
 		status = "disabled";
 	};
-- 
2.18.0
