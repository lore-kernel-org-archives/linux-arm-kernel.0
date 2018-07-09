From: robh@kernel.org (Rob Herring)
Date: Mon,  9 Jul 2018 09:41:49 -0600
Subject: [PATCH v4 2/6] dt-bindings: pinctrl: add a 'pinctrl-use-default'
 property
In-Reply-To: <20180709154153.15742-1-robh@kernel.org>
References: <20180709154153.15742-1-robh@kernel.org>
Message-ID: <20180709154153.15742-3-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pin setup may be optional in some cases such as the reset default works
or the pin setup is done by the bootloader. In these cases, it is optional
for the OS to support managing the pin controller and pin setup. In order
to support this scenario, add a property 'pinctrl-use-default' to indicate
that the pin configuration is optional.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/pinctrl-bindings.txt        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
index ad9bbbba36e9..cef2b5855d60 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
@@ -103,6 +103,12 @@ Optional properties:
 #pinctrl-cells:	Number of pin control cells in addition to the index within the
 		pin controller device instance
 
+pinctrl-use-default: Boolean. Indicates that the OS can use the boot default
+		pin configuration. This allows using an OS that does not have a
+		driver for the pin controller. This property can be set either
+		globally for the pin controller or in child nodes for individual
+		pin group control.
+
 Pin controller devices should contain the pin configuration nodes that client
 devices reference.
 
-- 
2.17.1
