From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 15 Nov 2014 10:49:11 +0000
Subject: [PATCH 0/2] Stacked domains and MSI improvements
Message-ID: <1416048553-29289-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This short series builds upon Jiang Liu's MSI stacked domain and tries
to clean up a couple of points:

- Patch 1 allows an msi_chip to carry a pointer to its irq domain.
  When populated by the MSI driver, this allow the PCI bus to be
  associated with an irq domain, removing most of the need for arch
  specific code in the case of multiple PCI busses.

- Patch 2 tries to work around a limitation of __irq_set_handler when
  called with an interrupt belongging to a stacked domain.

This has been tested on arm64, together with the GICv3 ITS.

Marc Zyngier (2):
  PCI/MSI: Allow an msi_chip to be associated to an irq domain
  genirq: Work around __irq_set_handler vs stacked domains ordering
    issues

 drivers/pci/msi.c   | 16 +++++++++++++++-
 include/linux/msi.h |  3 +++
 kernel/irq/chip.c   | 11 ++++++++++-
 3 files changed, 28 insertions(+), 2 deletions(-)

-- 
2.1.0
