From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Tue, 12 Jun 2018 22:00:19 +0200
Subject: [PATCH v2 10/27] dt-bindings: display: sun4i-drm: Add R40 TV TCON
 description
In-Reply-To: <20180612200036.21483-1-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
Message-ID: <20180612200036.21483-11-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TCON description is expanded with R40 TV TCON compatibles. TV TCONs,
which are connected to TCON TOP muxes, such as those on R40 SoC, also
needs additional clock gate to be specified.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../devicetree/bindings/display/sunxi/sun4i-drm.txt          | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index ef64c589a4b3..68c4b2995624 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -145,6 +145,7 @@ Required properties:
    * allwinner,sun8i-a33-tcon
    * allwinner,sun8i-a83t-tcon-lcd
    * allwinner,sun8i-a83t-tcon-tv
+   * allwinner,sun8i-r40-tcon-tv
    * allwinner,sun8i-v3s-tcon
    * allwinner,sun9i-a80-tcon-lcd
    * allwinner,sun9i-a80-tcon-tv
@@ -178,8 +179,10 @@ For TCONs with channel 0, there is one more clock required:
    - 'tcon-ch0': The clock driving the TCON channel 0
 For TCONs with channel 1, there is one more clock required:
    - 'tcon-ch1': The clock driving the TCON channel 1
+TV TCONs which are connected to TCON TOP (found in R40 SoC) need one more clock:
+   - 'tcon-top': TV TCON gate found in TCON TOP unit
 
-When TCON support LVDS (all TCONs except TV TCON on A83T and those found
+When TCON support LVDS (all TCONs except TV TCONs on A83T, R40 and those found
 in A13, H3, H5 and V3s SoCs), you need one more reset line:
    - 'lvds': The reset line driving the LVDS logic
 
-- 
2.17.1
