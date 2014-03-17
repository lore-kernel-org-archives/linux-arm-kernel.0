From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 17 Mar 2014 19:31:54 +0100
Subject: [PATCH 0/4] ata: add remaining new-style AHCI platform drivers
Message-ID: <1395081118-15248-1-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series adds new-style AHCI platform drivers for DaVinci DA850
AHCI controller and ST SPEAr1340 AHCI controller.  As a preparation for
adding these drivers it also fixes ahci_platform_data->suspend() handling
(patch #1) and moves library AHCI platform code to its own file (patch #2).
The new AHCI platform drivers are only compile tested (they are marked as
experimental because of this) and I would ask somebody with the hardware
to verify them (thanks!).

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
  ata: add new-style AHCI platform driver for ST SPEAr1340 AHCI
    controller

 drivers/ata/Kconfig            |  23 +-
 drivers/ata/Makefile           |  10 +-
 drivers/ata/ahci_da850.c       | 178 ++++++++++++++
 drivers/ata/ahci_platform.c    | 508 --------------------------------------
 drivers/ata/ahci_spear1340.c   | 222 +++++++++++++++++
 drivers/ata/libahci_platform.c | 541 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 967 insertions(+), 515 deletions(-)
 create mode 100644 drivers/ata/ahci_da850.c
 create mode 100644 drivers/ata/ahci_spear1340.c
 create mode 100644 drivers/ata/libahci_platform.c

-- 
1.8.2.3
