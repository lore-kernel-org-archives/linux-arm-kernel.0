From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri, 27 Jul 2018 01:12:55 +0800
Subject: [PATCH v3.1 08/10] dt-bindings: sun4i-drm: add HDMI VCC supply
 property for sun8i-dw-hdmi
In-Reply-To: <20180726171257.6688-1-icenowy@aosc.io>
References: <20180726171257.6688-1-icenowy@aosc.io>
Message-ID: <20180726171257.6688-9-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwiner SoCs with DesignWare HDMI controller all come with a "HVCC"
pin, which is the VCC of HDMI part.

Add a supply property to specify HVCC's regulator in the device tree.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v3.1:
- New patch.

 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index fdb8fb29033f..cb4769913e89 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -97,6 +97,9 @@ Required properties:
     first port should be the input endpoint. The second should be the
     output, usually to an HDMI connector.
 
+Optional properties:
+  - hdmi-supply: the VCC power supply of the controller
+
 DWC HDMI PHY
 ------------
 
-- 
2.18.0
