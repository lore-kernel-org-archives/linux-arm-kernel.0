From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  8 Sep 2016 12:26:08 +0200
Subject: [PATCH v3 1/3] ARM: sunxi: Support the Nextthing GR8
In-Reply-To: <20160908102610.26783-1-maxime.ripard@free-electrons.com>
References: <20160908102610.26783-1-maxime.ripard@free-electrons.com>
Message-ID: <20160908102610.26783-2-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GR8 is an SoC made by Nextthing Co, loosely based on the sun5i family.

It has a number of new controllers compared to the A10s and A13 (SPDIF, I2S),
but some controllers missing too (Ethernet, less I2C, less UARTs).

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/arm/sunxi/README                  | 2 ++
 Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
 MAINTAINERS                                     | 1 +
 arch/arm/mach-sunxi/sunxi.c                     | 1 +
 4 files changed, 5 insertions(+)

diff --git a/Documentation/arm/sunxi/README b/Documentation/arm/sunxi/README
index e5a115f24471..77f57efbea83 100644
--- a/Documentation/arm/sunxi/README
+++ b/Documentation/arm/sunxi/README
@@ -31,6 +31,8 @@ SunXi family
         + User Manual
           http://dl.linux-sunxi.org/A13/A13%20User%20Manual%20-%20v1.2%20%282013-01-08%29.pdf
 
+      - Next Thing Co GR8 (sun5i)
+
     * Dual ARM Cortex-A7 based SoCs
       - Allwinner A20 (sun7i)
         + User Manual
diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
index 7e79fcc36b0d..3975d0a0e4c2 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.txt
+++ b/Documentation/devicetree/bindings/arm/sunxi.txt
@@ -14,3 +14,4 @@ using one of the following compatible strings:
   allwinner,sun8i-a83t
   allwinner,sun8i-h3
   allwinner,sun9i-a80
+  nextthing,gr8
diff --git a/MAINTAINERS b/MAINTAINERS
index 20bb1d00098c..7be47efb2159 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -982,6 +982,7 @@ M:	Chen-Yu Tsai <wens@csie.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 N:	sun[x456789]i
+F:	arch/arm/boot/dts/ntc-gr8*
 
 ARM/Allwinner SoC Clock Support
 M:	Emilio L?pez <emilio@elopez.com.ar>
diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index 95dca8c2c9ed..2e2bde271205 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -22,6 +22,7 @@ static const char * const sunxi_board_dt_compat[] = {
 	"allwinner,sun5i-a10s",
 	"allwinner,sun5i-a13",
 	"allwinner,sun5i-r8",
+	"nextthing,gr8",
 	NULL,
 };
 
-- 
2.9.3
