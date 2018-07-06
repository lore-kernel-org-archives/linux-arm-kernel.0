From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Fri,  6 Jul 2018 19:51:09 +0200
Subject: [PATCH 13/17] ARM: dts: sun8i: r40: Remove fallback compatible for
 TCON TV
In-Reply-To: <20180706175113.26698-1-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
Message-ID: <20180706175113.26698-14-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While registers between A83T and R40 TV TCON are the same, R40 TCON TV
driver has to set additional muxes in TCON TOP. Because of that, remove
fallback A83T TCON TV compatible.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 1dd088d82773..6b4fe8eeee99 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -666,8 +666,7 @@
 		};
 
 		tcon_tv0: lcd-controller at 1c73000 {
-			compatible = "allwinner,sun8i-r40-tcon-tv",
-				     "allwinner,sun8i-a83t-tcon-tv";
+			compatible = "allwinner,sun8i-r40-tcon-tv";
 			reg = <0x01c73000 0x1000>;
 			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_TCON_TV0>, <&tcon_top 0>;
@@ -690,8 +689,7 @@
 		};
 
 		tcon_tv1: lcd-controller at 1c74000 {
-			compatible = "allwinner,sun8i-r40-tcon-tv",
-				     "allwinner,sun8i-a83t-tcon-tv";
+			compatible = "allwinner,sun8i-r40-tcon-tv";
 			reg = <0x01c74000 0x1000>;
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_TCON_TV1>, <&tcon_top 1>;
-- 
2.18.0
