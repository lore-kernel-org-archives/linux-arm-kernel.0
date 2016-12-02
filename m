From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri,  2 Dec 2016 14:48:11 +0100
Subject: [RESEND PATCH v2 5/7] drm/vc4: Document VEC DT binding
In-Reply-To: <1480686493-4813-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1480686493-4813-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1480686493-4813-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the DT binding for the VEC (Video EnCoder) IP.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt b/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt
index a5ea451e67fc..e2768703ac2b 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt
+++ b/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt
@@ -43,6 +43,13 @@ Required properties for DPI:
 - port:		Port node with a single endpoint connecting to the panel
 		  device, as defined in [1]
 
+Required properties for VEC:
+- compatible:	Should be "brcm,bcm2835-vec"
+- reg:		Physical base address and length of the registers
+- clocks:	The core clock the unit runs on
+- interrupts:	The interrupt number
+		  See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
+
 Required properties for V3D:
 - compatible:	Should be "brcm,bcm2835-v3d"
 - reg:		Physical base address and length of the V3D's registers
@@ -92,6 +99,13 @@ dpi: dpi at 7e208000 {
 	};
 };
 
+vec: vec at 7e806000 {
+	compatible = "brcm,bcm2835-vec";
+	reg = <0x7e806000 0x1000>;
+	clocks = <&clocks BCM2835_CLOCK_VEC>;
+	interrupts = <2 27>;
+};
+
 v3d: v3d at 7ec00000 {
 	compatible = "brcm,bcm2835-v3d";
 	reg = <0x7ec00000 0x1000>;
-- 
2.7.4
