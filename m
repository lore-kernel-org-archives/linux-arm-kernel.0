From: richard.zhu@linaro.org (Richard Zhu)
Date: Wed, 31 Aug 2011 11:50:30 +0800
Subject: [PATCH V7 0/5] imx53 ahci driver v7
Message-ID: <1314762635-3923-1-git-send-email-richard.zhu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

*** BLURB HERE ***
This is the seventh iteration of the imx53 ahci patch. Changes between
v5 and v7 are described in the following description.

ChangeLog v5->v6:
 - Move the most ahci initialization codes from the board related files
 to the common ahci_sata file.

 - Add the imx53 ahci's own ata_port_info definition in ahci_platform
 driver, since the 'ahci_pmp_retry_srst_ops' is required when imx53
 ahci is present.

ChangeLog v6->v7:
 - Define the default imx53 ahci platform data, reduce the modificatons
 on the board related files.

 - Handle the sata_pwr_en pin obviously on smd board.


Richard Zhu (5):
  AHCI Add the AHCI SATA feature on the MX53 platforms
  ahci_plt Add the board_ids and pi refer to different features
  MX53 Enable the AHCI SATA on MX53 ARD board
  MX53 Enable the AHCI SATA on MX53 LOCO board
  MX53 Enable the AHCI SATA on MX53 SMD board

 arch/arm/mach-mx5/board-mx53_ard.c              |    1 +
 arch/arm/mach-mx5/board-mx53_loco.c             |    1 +
 arch/arm/mach-mx5/board-mx53_smd.c              |   32 +++++++
 arch/arm/mach-mx5/clock-mx51-mx53.c             |   19 ++++
 arch/arm/mach-mx5/devices-imx53.h               |    4 +
 arch/arm/plat-mxc/Makefile                      |    1 +
 arch/arm/plat-mxc/ahci_sata.c                   |  104 +++++++++++++++++++++++
 arch/arm/plat-mxc/devices/Kconfig               |    4 +
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-ahci-imx.c   |   66 ++++++++++++++
 arch/arm/plat-mxc/include/mach/ahci_sata.h      |   33 +++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |   10 ++
 drivers/ata/ahci_platform.c                     |   44 ++++++++--
 13 files changed, 314 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/plat-mxc/ahci_sata.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-ahci-imx.c
 create mode 100644 arch/arm/plat-mxc/include/mach/ahci_sata.h
