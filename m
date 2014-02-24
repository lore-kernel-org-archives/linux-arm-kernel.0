From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 24 Feb 2014 09:42:54 +0100
Subject: [PATCH 02/10] devicetree: bindings: update MVEBU pinctrl binding
 documentation
In-Reply-To: <1393231382-11078-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1393231382-11078-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1393231382-11078-3-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dove pinctrl binding now requires three different reg properties. This
updates corresponding binding and example accordingly. While at it, also
document reg property as required for the other MVEBU SoC pinctrl nodes.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Rob Landley <rob@landley.net>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: devicetree at vger.kernel.org
Cc: linux-doc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 .../devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt          | 1 +
 .../devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt          | 1 +
 .../devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt          | 1 +
 Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt | 1 +
 Documentation/devicetree/bindings/pinctrl/marvell,dove-pinctrl.txt      | 1 +
 Documentation/devicetree/bindings/pinctrl/marvell,kirkwood-pinctrl.txt  | 1 +
 Documentation/devicetree/bindings/pinctrl/marvell,mvebu-pinctrl.txt     | 2 +-
 7 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
index 01ef408e205f..adda2a8d1d52 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
@@ -5,6 +5,7 @@ part and usage.
 
 Required properties:
 - compatible: "marvell,88f6710-pinctrl"
+- reg: register specifier of MPP registers
 
 Available mpp pins/groups and functions:
 Note: brackets (x) are not part of the mpp name for marvell,function and given
diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
index 2ede59dffe1b..7de0cda4a379 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
@@ -5,6 +5,7 @@ part and usage.
 
 Required properties:
 - compatible: "marvell,88f6720-pinctrl"
+- reg: register specifier of MPP registers
 
 Available mpp pins/groups and functions:
 Note: brackets (x) are not part of the mpp name for marvell,function and given
diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
index 1d45f9d62346..b17c96849fc9 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
@@ -7,6 +7,7 @@ Required properties:
 - compatible: "marvell,88f6810-pinctrl", "marvell,88f6820-pinctrl" or
   "marvell,88f6828-pinctrl" depending on the specific variant of the
   SoC being used.
+- reg: register specifier of MPP registers
 
 Available mpp pins/groups and functions:
 Note: brackets (x) are not part of the mpp name for marvell,function and given
diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
index bfa0a2e5e0cb..373dbccd7ab0 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
@@ -6,6 +6,7 @@ part and usage.
 Required properties:
 - compatible: "marvell,mv78230-pinctrl", "marvell,mv78260-pinctrl",
               "marvell,mv78460-pinctrl"
+- reg: register specifier of MPP registers
 
 This driver supports all Armada XP variants, i.e. mv78230, mv78260, and mv78460.
 
diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,dove-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,dove-pinctrl.txt
index 50ec3512a292..cf52477cc7ee 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,dove-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,dove-pinctrl.txt
@@ -6,6 +6,7 @@ part and usage.
 Required properties:
 - compatible: "marvell,dove-pinctrl"
 - clocks: (optional) phandle of pdma clock
+- reg: register specifiers of MPP, MPP4, and PMU MPP registers
 
 Available mpp pins/groups and functions:
 Note: brackets (x) are not part of the mpp name for marvell,function and given
diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,kirkwood-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,kirkwood-pinctrl.txt
index 95daf6335c37..730444a9a4de 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,kirkwood-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,kirkwood-pinctrl.txt
@@ -8,6 +8,7 @@ Required properties:
               "marvell,88f6190-pinctrl", "marvell,88f6192-pinctrl",
               "marvell,88f6281-pinctrl", "marvell,88f6282-pinctrl"
               "marvell,98dx4122-pinctrl"
+- reg: register specifier of MPP registers
 
 This driver supports all kirkwood variants, i.e. 88f6180, 88f619x, and 88f628x.
 It also support the 88f6281-based variant in the 98dx412x Bobcat SoCs.
diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,mvebu-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,mvebu-pinctrl.txt
index 0a26c3aa4e6d..0c09f4eb2af0 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,mvebu-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,mvebu-pinctrl.txt
@@ -37,7 +37,7 @@ uart1: serial at 12100 {
 
 pinctrl: pinctrl at d0200 {
 	compatible = "marvell,dove-pinctrl";
-	reg = <0xd0200 0x20>;
+	reg = <0xd0200 0x14>, <0xd0440 0x04>, <0xd802c 0x08>;
 
 	pmx_uart1_sw: pmx-uart1-sw {
 		marvell,pins = "mpp_uart1";
-- 
1.8.5.3
