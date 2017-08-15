From: oza.oza@broadcom.com (Oza Pawandeep)
Date: Tue, 15 Aug 2017 11:25:44 +0530
Subject: [PATCH v2 0/3] PCI hotplug feature
Message-ID: <1502776547-30542-1-git-send-email-oza.oza@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches bring in PCI hotplug support for iproc family chipsets.

It includes DT binding documentation update and, implementation in
iproc pcie RC driver.

These patch set is made on top of following patches.
[PATCH v6 2/2] PCI: iproc: add device shutdown for PCI RC
[PATCH v6 1/2] PCI: iproc: Retry request when CRS returned from EP

Changes since v2:
Addressed Rob Herring's comments.
Made generic PCI hotplug properties 'slot-pluggable' and 'prsnt-gpios'

Oza Pawandeep (3):
  PCI: iproc: Implement PCI hotplug support
  Documentation/devicetree: Add PCIe hotplug property
  PCI: iproc: Implement optional property prsnt-gpios

 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  14 +++
 Documentation/devicetree/bindings/pci/pci.txt      |  15 +++
 drivers/pci/host/pcie-iproc-platform.c             |   3 +
 drivers/pci/host/pcie-iproc.c                      | 130 ++++++++++++++++++++-
 drivers/pci/host/pcie-iproc.h                      |   7 ++
 5 files changed, 163 insertions(+), 6 deletions(-)

-- 
1.9.1
