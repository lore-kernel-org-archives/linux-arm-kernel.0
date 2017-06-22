From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Thu, 22 Jun 2017 22:49:00 +0800
Subject: [PATCH V5 1/1] dt-bindings: pinctrl: extend the pinmux property to
 support integers array
In-Reply-To: <1498046395-30001-2-git-send-email-aisheng.dong@nxp.com>
References: <1498046395-30001-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1498142940-7982-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms may need more than one integer to represent a complete
pinmux binding, so let's extend the pinmux property to allow to accept
integer array instead of only a single integer.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree at vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v4->v5:
 * doc improvement
v4:
 * new patch
---
 .../devicetree/bindings/pinctrl/pinctrl-bindings.txt      | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
index f01d154..30f1d9e 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
@@ -204,21 +204,22 @@ each single pin the number of required sub-nodes containing "pin" and
 maintain.
 
 For cases like this, the pin controller driver may use the pinmux helper
-property, where the pin identifier is packed with mux configuration settings
-in a single integer.
+property, where the pin identifier is provided with mux configuration settings
+in a pinmux group. A pinmux group consists of the pin identifier and mux
+settings represented as a single integer or an array of integers.
 
-The pinmux property accepts an array of integers, each of them describing
+The pinmux property accepts an array of pinmux groups, each of them describing
 a single pin multiplexing configuration.
 
 pincontroller {
 	state_0_node_a {
-		pinmux = <PIN_ID_AND_MUX>, <PIN_ID_AND_MUX>, ...;
+		pinmux = <PINMUX_GROUP>, <PINMUX_GROUP>, ...;
 	};
 };
 
 Each individual pin controller driver bindings documentation shall specify
-how those values (pin IDs and pin multiplexing configuration) are defined and
-assembled together.
+how pin IDs and pin multiplexing configuration are defined and assembled
+together in a pinmux group.
 
 == Generic pin configuration node content ==
 
@@ -300,7 +301,7 @@ arguments are described below.
 - pinmux takes a list of pin IDs and mux settings as required argument. The
   specific bindings for the hardware defines:
   - How pin IDs and mux settings are defined and assembled together in a single
-    integer.
+    integer or an array of integers.
 
 - bias-pull-up, -down and -pin-default take as optional argument on hardware
   supporting it the pull strength in Ohm. bias-disable will disable the pull.
-- 
2.7.4
