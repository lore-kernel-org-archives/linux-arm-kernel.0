From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 23 Jul 2015 17:52:42 +0100
Subject: [PATCH 0/3] Generic PCI MSI + IOMMU topology bindings
Message-ID: <1437670365-20704-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Currently we have no generic/standard mechanisms for describing the
relationship between PCI root complexes and other components which may be
required to make them usable, specifically IOMMUs and MSI controllers.

There is an existing binding for IOMMUs, and there is a de-facto standard for
referring to MSI controllers, but the generic portion of these can only
describe a relationship with a root complex as opposed to a device under a root
complex. This falls apart where IOMMUs and MSI controllers may distinguish
individual devices based on non-probeable information.

This series adds a generic "glue" bindings for describing the relationship
between root complexes, IOMMUs, and MSI controllers. The existing de-facto
binding for MSI controllers is formalised, along with a (backwards compatible)
extension necessary for describing contemporary MSI controllers which make use
of (non-probeable) sideband data.

Thanks,
Mark.

Mark Rutland (3):
  Docs: dt: add generic MSI bindings
  Docs: dt: Add PCI MSI map bindings
  Docs: dt: add PCI IOMMU map bindings

 .../bindings/interrupt-controller/msi.txt          | 135 +++++++++++++
 .../devicetree/bindings/pci/pci-iommu.txt          | 171 ++++++++++++++++
 Documentation/devicetree/bindings/pci/pci-msi.txt  | 220 +++++++++++++++++++++
 3 files changed, 526 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/msi.txt
 create mode 100644 Documentation/devicetree/bindings/pci/pci-iommu.txt
 create mode 100644 Documentation/devicetree/bindings/pci/pci-msi.txt

-- 
1.9.1
