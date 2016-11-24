From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 24 Nov 2016 14:43:38 +0800
Subject: [PATCH 1/2] ARM: dts: sun6i: Disable display pipeline by default
In-Reply-To: <20161124064339.12615-1-wens@csie.org>
References: <20161124064339.12615-1-wens@csie.org>
Message-ID: <20161124064339.12615-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While we now support the internal display pipeline found on sun6i, it
is possible that we are unable to enable the display for some boards,
due to a lack of drivers for the panels or bridges found on them. If
the display pipeline is enabled, the driver will try to enable, and
possibly screw up the simple framebuffer U-boot had configured.

Disable the display pipeline by default.

Fixes: 6d0e5b70be13 ("ARM: dts: sun6i: Add device nodes for first
		      display pipeline")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 20a0331ddfb5..4662d3344cd2 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -234,6 +234,7 @@
 	de: display-engine {
 		compatible = "allwinner,sun6i-a31-display-engine";
 		allwinner,pipelines = <&fe0>;
+		status = "disabled";
 	};
 
 	soc at 01c00000 {
-- 
2.10.2
