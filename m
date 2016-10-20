From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Oct 2016 15:49:04 +0200
Subject: [PATCH v3 3/6] dt-bindings: pinctrl: Deprecate sunxi pinctrl bindings
In-Reply-To: <cover.f893b02a9f816dad8fad3986672b05c4b211e2b1.1476971126.git-series.maxime.ripard@free-electrons.com>
References: <cover.f893b02a9f816dad8fad3986672b05c4b211e2b1.1476971126.git-series.maxime.ripard@free-electrons.com>
Message-ID: <6aec73cd3b9d3dbf1085d042ec6c23f385a300de.1476971126.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The generic pin configuration and multiplexing should be preferred now,
even though we still support the old one.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
index 1685821eea41..35eef433e518 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
@@ -37,6 +37,22 @@ pins it needs, and how they should be configured, with regard to muxer
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
