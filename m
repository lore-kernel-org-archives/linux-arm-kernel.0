From: eric@anholt.net (Eric Anholt)
Date: Wed,  7 Mar 2018 10:57:13 -0800
Subject: [PATCH v2 3/6] dt-bindings: soc: Add a binding for the Broadcom VCHIQ
 services.
In-Reply-To: <20180307185716.17449-1-eric@anholt.net>
References: <20180307185716.17449-1-eric@anholt.net>
Message-ID: <20180307185716.17449-3-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VCHIQ communication channel can be provided by BCM283x and Capri
SoCs, to communicate with the VPU-side OS services.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

v2: dropped firmware property, added cache-line-size.

 .../bindings/soc/bcm/brcm,bcm2835-vchiq.txt        | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt

diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
new file mode 100644
index 000000000000..cdef4abc5e47
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
@@ -0,0 +1,28 @@
+Broadcom VCHIQ firmware services
+
+Required properties:
+
+- compatible:	Should be "brcm,bcm2835-vchiq"
+- reg:		Physical base address and length of the doorbell register pair
+- interrupts:	The interrupt number
+		  See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
+
+Optional properties:
+
+- cache-line-size:
+		Size of L2 cache lines.  The VPU firmware detects
+		  this property and overrides it with the actual L2
+		  cache line size it's using when loading the
+		  device-tree.  Determines the required alignment of
+		  offsets/sizes of VCHIQ pagelists.  If missing, the
+		  firmware assumes an older kernel using 32-byte
+		  alignment.
+
+Example:
+
+vchiq at 7e00b840 {
+	compatible = "brcm,bcm2835-vchiq";
+	reg = <0x7e00b840 0xf>;
+	interrupts = <0 2>;
+	cache-line-size: <32>;
+};
-- 
2.16.2
