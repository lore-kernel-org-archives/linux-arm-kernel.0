From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Fri,  2 Dec 2016 23:05:12 +0800
Subject: [PATCH v3 -next 1/2] ARM: sunxi: add support for H2+ SoC
Message-ID: <20161202150513.34691-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner H2+ is a quad-core Cortex-A7 SoC.

It is very like H3, that they share the same SoC ID (0x1680), and H3
memory maps as well as drivers works well on the SoC.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Changes since v2:
- Changed compatible from allwinner,sun8i-h2plus to allwinner,sun8i-h2-plus.
 Documentation/arm/sunxi/README                  | 4 ++++
 Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
 arch/arm/mach-sunxi/sunxi.c                     | 1 +
 3 files changed, 6 insertions(+)

diff --git a/Documentation/arm/sunxi/README b/Documentation/arm/sunxi/README
index cd02433..1fe4d99c 100644
--- a/Documentation/arm/sunxi/README
+++ b/Documentation/arm/sunxi/README
@@ -63,6 +63,10 @@ SunXi family
         + User Manual
           http://dl.linux-sunxi.org/A33/A33%20user%20manual%20release%201.1.pdf
 
+      - Allwinner H2+ (sun8i)
+        + No document available now, but is known to be working properly with
+          H3 drivers and memory map.
+
       - Allwinner H3 (sun8i)
         + Datasheet
           http://dl.linux-sunxi.org/H3/Allwinner_H3_Datasheet_V1.0.pdf
diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
index 4d6467c..59b143f 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.txt
+++ b/Documentation/devicetree/bindings/arm/sunxi.txt
@@ -13,6 +13,7 @@ using one of the following compatible strings:
   allwinner,sun8i-a33
   allwinner,sun8i-a83t
   allwinner,sun8i-h3
+  allwinner,sun8i-h2-plus
   allwinner,sun9i-a80
   allwinner,sun50i-a64
   nextthing,gr8
diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index 2e2bde2..320d2af 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -63,6 +63,7 @@ static const char * const sun8i_board_dt_compat[] = {
 	"allwinner,sun8i-a23",
 	"allwinner,sun8i-a33",
 	"allwinner,sun8i-a83t",
+	"allwinner,sun8i-h2-plus",
 	"allwinner,sun8i-h3",
 	NULL,
 };
-- 
2.10.2
