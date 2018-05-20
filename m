From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 21 May 2018 01:01:47 +0800
Subject: [PATCH v1 1/7] dt-bindings: pinctrl: add external interrupt support
 to MT7622 pinctrl
In-Reply-To: <cover.1526835466.git.sean.wang@mediatek.com>
References: <cover.1526835466.git.sean.wang@mediatek.com>
Message-ID: <3898620ef606004aaddc332591ca467f56773029.1526835466.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Extend the capability of MT7622 pinctrl with adding EINT so that each
GPIO can be used to notify CPU when a signal state is changing on the
line as an external interrupt.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt
index f18ed99..743b32d 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt
@@ -9,6 +9,16 @@ Required properties for the root node:
  - #gpio-cells: Should be two. The first cell is the pin number and the
    second is the GPIO flags.
 
+Optional properties:
+- interrupt-controller  : Marks the device node as an interrupt controller
+
+If the property interrupt-controller is defined, following property is required
+- reg-names: A string describing the "reg" entries. Must contain "eint".
+- interrupts : The interrupt output from the controller.
+- #interrupt-cells: Should be two.
+- interrupt-parent: Phandle of the interrupt parent to which the external
+  GPIO interrupts are forwarded to.
+
 Please refer to pinctrl-bindings.txt in this directory for details of the
 common pinctrl bindings used by client devices, including the meaning of the
 phrase "pin configuration node".
-- 
2.7.4
