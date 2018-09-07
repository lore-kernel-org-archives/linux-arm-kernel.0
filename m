From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri,  7 Sep 2018 15:22:30 +0800
Subject: [PATCH 1/5] dt-bindings: sun4i-drm: drop second PLL from A64 HDMI PHY
 binding
In-Reply-To: <20180907072234.48282-1-icenowy@aosc.io>
References: <20180907072234.48282-1-icenowy@aosc.io>
Message-ID: <20180907072234.48282-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By experiments it seems that the A64 HDMI PHY is not able to use the
second video PLL as the clock parent.

Drop pll-1 from the device tree binding of A64 HDMI PHY.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index f8773ecb7525..62034039cee1 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -114,7 +114,6 @@ Required properties:
 
 H3 and A64 HDMI PHY require additional clocks:
   - pll-0: parent of phy clock
-  - pll-1: second possible phy clock parent (A64 only)
 
 TV Encoder
 ----------
-- 
2.18.0
