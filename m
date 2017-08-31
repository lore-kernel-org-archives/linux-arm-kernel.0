From: oza.oza@broadcom.com (Oza Pawandeep)
Date: Thu, 31 Aug 2017 10:14:27 +0530
Subject: [PATCH v5 0/3] PCI hotplug feature
Message-ID: <1504154670-24608-1-git-send-email-oza.oza@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches bring in PCI hotplug support for iproc family chipsets.

It includes DT binding documentation and, the implementation in
iproc pcie RC driver.

Changes since v3:
Rebased to pci-next
Added; Acked-by: Rob Herring <robh@kernel.org>

Changes since v3:
Resend. just to be in sync previous in-flight patches.

Changes since v2:
Addressed Rob Herring's comments.
Changed subject to "dt-bindings: PCI:..."
Made generic PCI hotplug properties 'slot-pluggable' and 'prsnt-gpios'
Rebased the patches on top of Lorenzo's patches.

Oza Pawandeep (3):
  dt-bindings: PCI: Add PCI hotplug property
  dt-bindings: PCI iproc: Implement optional property prsnt-gpios
  PCI: iproc: Implement PCI hotplug support

 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  14 ++
 Documentation/devicetree/bindings/pci/pci.txt      |  15 ++
 drivers/pci/host/pcie-iproc-platform.c             |   3 +
 drivers/pci/host/pcie-iproc.c                      | 166 ++++++++++++++++++---
 drivers/pci/host/pcie-iproc.h                      |   7 +
 5 files changed, 187 insertions(+), 18 deletions(-)

-- 
1.9.1
