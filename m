From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Wed, 16 Aug 2017 16:54:08 -0500
Subject: [PATCH v2 2/2] dt-bindings: usb: keystone-usb: Update bindings pm and
 clocks properties
In-Reply-To: <20170816215408.13076-1-fcooper@ti.com>
References: <20170816215408.13076-1-fcooper@ti.com>
Message-ID: <20170816215408.13076-3-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update various properties to properly indicate their requirement depending
on the SoC.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
Version 2:
Clarify clock requirements in binding document

 Documentation/devicetree/bindings/usb/keystone-usb.txt | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/keystone-usb.txt b/Documentation/devicetree/bindings/usb/keystone-usb.txt
index 60527d3..2d1bef1 100644
--- a/Documentation/devicetree/bindings/usb/keystone-usb.txt
+++ b/Documentation/devicetree/bindings/usb/keystone-usb.txt
@@ -12,8 +12,21 @@ Required properties:
    MPU.
  - ranges: allows valid 1:1 translation between child's address space and
    parent's address space.
- - clocks: Clock IDs array as required by the controller.
- - clock-names: names of clocks correseponding to IDs in the clock property.
+
+SoC-specific Required Properties:
+The following are mandatory properties for Keystone 2 66AK2HK, 66AK2L and 66AK2E
+SoCs only:
+
+- clocks:		Clock ID for USB functional clock.
+- clock-names:		Must be "usb".
+
+
+The following are mandatory properties for Keystone 2 66AK2G SoCs only:
+
+- power-domains:	Should contain a phandle to a PM domain provider node
+			and an args specifier containing the USB device id
+			value. This property is as per the binding,
+			Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
 
 Sub-nodes:
 The dwc3 core should be added as subnode to Keystone DWC3 glue.
-- 
2.9.4.dirty
