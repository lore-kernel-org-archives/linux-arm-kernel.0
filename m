From: oza.oza@broadcom.com (Oza Pawandeep)
Date: Tue, 22 Aug 2017 13:40:55 +0530
Subject: [PATCH v3 2/3] dt-bindings: PCI: Add PCIe hotplug property
In-Reply-To: <1503389456-27373-1-git-send-email-oza.oza@broadcom.com>
References: <1503389456-27373-1-git-send-email-oza.oza@broadcom.com>
Message-ID: <1503389456-27373-3-git-send-email-oza.oza@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Host drivers have the requirement of implementing PCI hotplug
based on the how their SOC supports PCI hotplug.

Couple of properties have been added. the one to enable
the hotplug feature itself, and the other caters to
the PCI hotplug implementation with the use of gpios.

Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>

diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
index 50f9e2c..0bf25a1 100644
--- a/Documentation/devicetree/bindings/pci/pci.txt
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -24,3 +24,18 @@ driver implementation may support the following properties:
    unsupported link speed, for instance, trying to do training for
    unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
    for gen2, and '1' for gen1. Any other values are invalid.
+
+- slot-pluggable:
+   PCI hotplug feature is supported.
+   PCI hotplug implementation is SOC/Board specific, and also it depends on
+   how add-in card is designed (e.g. how many present pins are implemented).
+   If the slot-pluggable property is present, the following propertey could
+   become effective.
+   - prsnt-gpios:
+      Array of gpios, could be present if hotplug is supported.
+      This property defines gpio based hotplug implementation.
+      Example:
+      If x8 card is connected, then it might be possible that all the
+      3 present pins could go low, or at least one pin goes low.
+      If x4 card is connected, then it might be possible that 2 present
+      pins go low, or at least one pin goes low.
-- 
1.9.1
