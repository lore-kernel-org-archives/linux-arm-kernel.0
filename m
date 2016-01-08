From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu,  7 Jan 2016 16:03:29 -0800
Subject: [PATCH 0/4] ata: ahci_brcmstb: ALPM support
Message-ID: <1452211413-1350-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tejun,

This patch series contains a bunch of changes to the Broadcom AHCI driver
to support ALPM, disable DIPM (not supported) and updates the core libata
to account for driver-specific ALPM-resume procedure.

The last patch in this series allows some particular drivers, which are known
not to need the debounce delay while resuming SATA links to skip these, which
yields a faster resume time.

This is against your ata/for-next branch, thanks!

Danesh Petigara (4):
  ata: ahci_brcmstb: enable support for ALPM
  ata: ahci_brcmstb: disable DIPM support
  drivers: ata: wake port before DMA stop for ALPM
  libata: skip debounce delay on link resume

 drivers/ata/ahci.h         |  6 ++++++
 drivers/ata/ahci_brcmstb.c | 40 ++++++++++++++++++++++++++++++++++-
 drivers/ata/libahci.c      | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/libata-core.c  |  4 +++-
 include/linux/libata.h     |  5 +++++
 5 files changed, 105 insertions(+), 2 deletions(-)

-- 
2.1.0
