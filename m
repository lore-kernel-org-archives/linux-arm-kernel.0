From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Mon, 16 Jul 2018 16:41:57 +0200
Subject: [PATCH v3 14/23] dt-bindings: ap806: prepare the syscon file to list
 other syscons nodes
In-Reply-To: <20180716144206.30985-1-miquel.raynal@bootlin.com>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
Message-ID: <20180716144206.30985-15-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are multiple system controllers in AP806. Because all syscon nodes
use the same compatible, it is pertinent to use this same file to list
IPs inside it. Thus, change the header to be more generic.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/arm/marvell/ap806-system-controller.txt           | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
index 0b887440e08a..a856eb9a4e05 100644
--- a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
@@ -2,14 +2,14 @@ Marvell Armada AP806 System Controller
 ======================================
 
 The AP806 is one of the two core HW blocks of the Marvell Armada 7K/8K
-SoCs. It contains a system controller, which provides a number
-registers giving access to numerous features: clocks, pin-muxing and
-many other SoC configuration items. This DT binding allows to describe
-this system controller.
+SoCs. It contains system controllers, which provide several registers
+giving access to numerous features: clocks, pin-muxing and many other
+SoC configuration items. This DT binding allows to describe these
+system controllers.
 
 For the top level node:
  - compatible: must be: "syscon", "simple-mfd";
-  - reg: register area of the AP806 system controller
+ - reg: register area of the AP806 system controller
 
 Clocks:
 -------
-- 
2.14.1
