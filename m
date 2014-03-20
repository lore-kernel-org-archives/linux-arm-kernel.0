From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 20 Mar 2014 19:27:03 +0100
Subject: [PATCH v2 0/3] ata: ahci_platform related cleanups
Message-ID: <1395340026-3969-1-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ v1 was named "ata: add remaining new-style AHCI platform drivers"
  but we are down from 2 drivers to 1 driver so the title of the patch
  series no longer was valid :) ]

Hi,

This patch series:
- fixes ahci_platform_data->suspend() handling
- moves library AHCI platform code to its own file
- adds a new-style AHCI platform driver for DaVinci DA850 AHCI controller

Changes since v1:
- dropped no longer needed patch #4 (ST SPEAr1340 AHCI controller driver)
- adressed review comments for patch #3 from Sekhar Nori
- updated patch descriptions

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

Bartlomiej Zolnierkiewicz (3):
  ata: ahci_platform: fix ahci_platform_data->suspend method handling
  ata: move library code from ahci_platform.c to libahci_platform.c
  ata: add new-style AHCI platform driver for DaVinci DA850 AHCI
    controller

 arch/arm/mach-davinci/devices-da8xx.c |  99 +------
 drivers/ata/Kconfig                   |  14 +-
 drivers/ata/Makefile                  |   9 +-
 drivers/ata/ahci_da850.c              | 116 ++++++++
 drivers/ata/ahci_platform.c           | 508 -------------------------------
 drivers/ata/libahci_platform.c        | 541 ++++++++++++++++++++++++++++++++++
 6 files changed, 681 insertions(+), 606 deletions(-)
 create mode 100644 drivers/ata/ahci_da850.c
 create mode 100644 drivers/ata/libahci_platform.c

-- 
1.8.2.3
