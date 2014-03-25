From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 25 Mar 2014 18:26:11 +0100
Subject: [PATCH v3 0/4] ata: ahci_platform related cleanups
Message-ID: <1395768375-21123-1-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series:
- fixes ahci_platform_data->suspend() handling
- moves library AHCI platform code to its own file
- adds a new-style AHCI platform driver for DaVinci DA850 AHCI controller
- updates DaVinci DA850 platform code

Changes since v2:
- merged changes from Sekhar
- splitted out DaVinci DA850 platform changes into separate patch

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (4):
  ata: ahci_platform: fix ahci_platform_data->suspend method handling
  ata: move library code from ahci_platform.c to libahci_platform.c
  ata: add new-style AHCI platform driver for DaVinci DA850 AHCI
    controller
  ARM: davinci: da850: update SATA AHCI support

 arch/arm/mach-davinci/da850.c         |   2 +-
 arch/arm/mach-davinci/devices-da8xx.c |  99 +------
 drivers/ata/Kconfig                   |  14 +-
 drivers/ata/Makefile                  |   9 +-
 drivers/ata/ahci_da850.c              | 114 +++++++
 drivers/ata/ahci_platform.c           | 508 -------------------------------
 drivers/ata/libahci_platform.c        | 541 ++++++++++++++++++++++++++++++++++
 7 files changed, 680 insertions(+), 607 deletions(-)
 create mode 100644 drivers/ata/ahci_da850.c
 create mode 100644 drivers/ata/libahci_platform.c

-- 
1.8.2.3
