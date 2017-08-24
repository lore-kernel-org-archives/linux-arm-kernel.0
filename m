From: oza.oza@broadcom.com (Oza Pawandeep)
Date: Thu, 24 Aug 2017 10:34:23 +0530
Subject: [PATCH v8 0/3] PCI: iproc: SOC specific fixes
Message-ID: <1503551066-23212-1-git-send-email-oza.oza@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCI: iproc: Retry request when CRS returned from EP Above patch adds
support for CRS in PCI RC driver, otherwise if not handled at lower
level, the user space PMD (poll mode drivers) can timeout.

PCI: iproc: add device shutdown for PCI RC This fixes the issue where
certian PCI endpoints are not getting detected on Stingray SOC after
reboot.

Changes Since v7:
Factor out the ep config access code.

Changes Since v6:
Rebased patches on top of Lorenzo's patches.
Bjorn's comments addressed.
now the confg retry returns 0xffffffff as data.
Added reference to PCIe spec and iproc Controller spec in Changelog.

Changes Since v5:
Ray's comments addressed.

Changes Since v4:
Bjorn's comments addressed.

Changes Since v3:
[re-send]

Changes Since v2:
Fix compilation errors for pcie-iproc-platform.ko which was caught
by kbuild.

Oza Pawandeep (3):
  PCI: iproc: factor-out ep configuration access
  PCI: iproc: Retry request when CRS returned from EP
  PCI: iproc: add device shutdown for PCI RC

 drivers/pci/host/pcie-iproc-platform.c |   8 ++
 drivers/pci/host/pcie-iproc.c          | 143 ++++++++++++++++++++++++++-------
 drivers/pci/host/pcie-iproc.h          |   1 +
 3 files changed, 124 insertions(+), 28 deletions(-)

-- 
1.9.1
