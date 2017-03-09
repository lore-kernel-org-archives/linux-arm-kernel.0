From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 09 Mar 2017 14:01:33 +0100
Subject: [PATCH 0/3] ATA/ARM: convert ARM/DaVinci to use libata PATA drivers
References: <CGME20170309130212epcas5p28ee9f513f932008f0222f9e95cfc4e57@epcas5p2.samsung.com>
Message-ID: <1489064496-6270-1-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset adds Palmchip BK3710 IDE controller driver to
libata and switches ARM/DaVinci to use it instead of the old
IDE driver.

Sekhar, please check that it still works after changes, thanks.

Changes since v0.1 draft patch version
(https://www.spinics.net/lists/arm-kernel/msg566932.html):
- fixed cycle_time build warning
- added platform support fixes from Sekhar
- added defconfig changes from Sekhar
- preserved platform support for the old IDE driver
- split it on 3 patches

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (1):
  ata: add Palmchip BK3710 PATA controller driver

Sekhar Nori (2):
  ARM: davinci: add pata_bk3710 libata driver support
  ARM: davinci_all_defconfig: convert to use libata PATA

 arch/arm/configs/davinci_all_defconfig    |   4 +-
 arch/arm/mach-davinci/board-dm644x-evm.c  |   3 +-
 arch/arm/mach-davinci/board-dm646x-evm.c  |   3 +-
 arch/arm/mach-davinci/board-neuros-osd2.c |   3 +-
 drivers/ata/Kconfig                       |   9 +
 drivers/ata/Makefile                      |   1 +
 drivers/ata/pata_bk3710.c                 | 395 ++++++++++++++++++++++++++++++
 7 files changed, 412 insertions(+), 6 deletions(-)
 create mode 100644 drivers/ata/pata_bk3710.c

-- 
1.9.1
