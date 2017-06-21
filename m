From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 21 Jun 2017 19:59:49 +0800
Subject: [PATCH V4 1/7] dt-bindings: pinctrl: extend the pinmux property to
 support integers array
In-Reply-To: <1498046395-30001-1-git-send-email-aisheng.dong@nxp.com>
References: <1498046395-30001-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1498046395-30001-2-git-send-email-aisheng.dong@nxp.com>
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
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
 * new patch
---
 Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
index f01d154..1b954b5 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
@@ -205,10 +205,11 @@ maintain.
 
 For cases like this, the pin controller driver may use the pinmux helper
 property, where the pin identifier is packed with mux configuration settings
-in a single integer.
+in a single integer or integers array which depends on platform binding
+specific.
 
-The pinmux property accepts an array of integers, each of them describing
-a single pin multiplexing configuration.
+The pinmux property accepts an array of group of integers, each group
+describing a single pin multiplexing configuration.
 
 pincontroller {
 	state_0_node_a {
@@ -300,7 +301,7 @@ arguments are described below.
 - pinmux takes a list of pin IDs and mux settings as required argument. The
   specific bindings for the hardware defines:
   - How pin IDs and mux settings are defined and assembled together in a single
-    integer.
+    integer or integers array.
 
 - bias-pull-up, -down and -pin-default take as optional argument on hardware
   supporting it the pull strength in Ohm. bias-disable will disable the pull.
-- 
2.7.4
