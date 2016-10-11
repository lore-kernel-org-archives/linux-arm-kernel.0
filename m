From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 11 Oct 2016 17:46:04 +0200
Subject: [PATCH v2 6/9] dt-bindings: pinctrl: Deprecate sunxi pinctrl bindings
In-Reply-To: <cover.7edc6c25be8a5e2efdda6a82e102dbf7ece6aa64.1476200742.git-series.maxime.ripard@free-electrons.com>
References: <cover.7edc6c25be8a5e2efdda6a82e102dbf7ece6aa64.1476200742.git-series.maxime.ripard@free-electrons.com>
Message-ID: <ee6d214a14ed31689c5f70fc6ee5736c3d26737b.1476200742.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The generic pin configuration and multiplexing should be preferred now,
even though we still support the old one.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
index 69617220c5d6..ff351493be47 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
@@ -36,6 +36,22 @@ pins it needs, and how they should be configured, with regard to muxer
 configuration, drive strength and pullups. If one of these options is
 not set, its actual value will be unspecified.
 
+This driver supports the generic pin multiplexing and configuration
+bindings. For details on each properties, you can refer to
+./pinctrl-bindings.txt.
+
+Required sub-node properties:
+  - pins
+  - function
+
+Optional sub-node properties:
+  - bias-disable
+  - bias-pull-up
+  - bias-pull-down
+  - drive-strength
+
+*** Deprecated pin configuration and multiplexing binding
+
 Required subnode-properties:
 
 - allwinner,pins: List of strings containing the pin name.
-- 
git-series 0.8.10
