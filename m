From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  2 Oct 2014 09:44:15 +0200
Subject: [PATCH] pinctrl: specify bindings for pins and groups
Message-ID: <1412235855-19418-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pin configurations can be per-pin or per-group. Make sure that the
per-group case is covered by the bindings.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/pinctrl/pinctrl-bindings.txt          | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
index 4f5a0c3af8b9..98eb94d91a1c 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
@@ -157,7 +157,12 @@ structure of the DT nodes that contain these properties.
 Supported generic properties are:
 
 pins			- the list of pins that properties in the node
-			  apply to
+			  apply to (either this or "group" has to be
+			  specified)
+group			- the group to apply the properties to, if the driver
+			  supports configuration of whole groups rather than
+			  individual pins (either this or "pins" has to be
+			  specified)
 bias-disable		- disable any pin bias
 bias-high-impedance	- high impedance mode ("third-state", "floating")
 bias-bus-hold		- latch weakly
@@ -190,6 +195,10 @@ state_1_node_a {
 	pins = "GPIO1_AJ3", "GPIO3_AH3"; /* RTS+TXD */
 	output-high;
 };
+state_2_node_a {
+	group = "foo-group";
+	bias-pull-up;
+};
 
 Some of the generic properties take arguments. For those that do, the
 arguments are described below.
-- 
1.9.3
