From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 30 Nov 2010 16:34:17 +0100
Subject: [GIT PULL] AT91: 2.6.37-rc4 at91rm9200 updates
Message-ID: <4CF51979.1070208@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Could you please pull the following:

  git://github.com/at91linux/linux-2.6-at91.git for_linus

This contains a set of AT91 updates since 2.6.37-rc4 based on your tree:
commit e8a7e48bb248a1196484d3f8afa53bded2b24e71

It removes several at91rm9200 defconfig and fixes issues and warnings
dicovered while testing it. This series has been reviewed on 
ARM mailing list.

Eric Benard (1):
      at91: merge all at91rm9200 defconfig in one single file

Jean-Christophe PLAGNIOL-VILLARD (7):
      at91: Convert remaining boards to new-style UART initialization
      at91rm9200dk: fix warning: 'dk_mmc_data' defined but not used
      at91rm9200ek: fix warning: 'ek_mmc_data' defined but not used
      at91: rename rm9200ek and rm9200dk board file name
      at91/picotux200: remove commenting usb device and dataflash support
      atmel_spi: fix warning In function 'atmel_spi_dma_map_xfer'
      at91/board-yl-9200: fix typo in video support

 arch/arm/configs/at91rm9200_defconfig              |  341 ++++++++++++++++++++
 arch/arm/configs/at91rm9200dk_defconfig            |   72 ----
 arch/arm/configs/at91rm9200ek_defconfig            |   73 -----
 arch/arm/configs/ateb9200_defconfig                |  131 --------
 arch/arm/configs/carmeva_defconfig                 |   47 ---
 arch/arm/configs/cpuat91_defconfig                 |  112 -------
 arch/arm/configs/csb337_defconfig                  |  104 ------
 arch/arm/configs/csb637_defconfig                  |   98 ------
 arch/arm/configs/ecbat91_defconfig                 |   99 ------
 arch/arm/configs/kafa_defconfig                    |   61 ----
 arch/arm/configs/kb9202_defconfig                  |  127 --------
 arch/arm/configs/onearm_defconfig                  |   80 -----
 arch/arm/configs/picotux200_defconfig              |  242 --------------
 arch/arm/configs/yl9200_defconfig                  |  137 --------
 arch/arm/mach-at91/Makefile                        |    4 +-
 arch/arm/mach-at91/at91rm9200_devices.c            |   45 ---
 arch/arm/mach-at91/board-1arm.c                    |   26 +-
 arch/arm/mach-at91/board-kafa.c                    |   21 +-
 arch/arm/mach-at91/board-picotux200.c              |   53 +---
 .../arm/mach-at91/{board-dk.c => board-rm9200dk.c} |    4 +-
 .../arm/mach-at91/{board-ek.c => board-rm9200ek.c} |    4 +-
 arch/arm/mach-at91/board-yl-9200.c                 |    2 +-
 arch/arm/mach-at91/include/mach/board.h            |    6 -
 drivers/spi/atmel_spi.c                            |    6 +-
 24 files changed, 386 insertions(+), 1509 deletions(-)
 create mode 100644 arch/arm/configs/at91rm9200_defconfig
 delete mode 100644 arch/arm/configs/at91rm9200dk_defconfig
 delete mode 100644 arch/arm/configs/at91rm9200ek_defconfig
 delete mode 100644 arch/arm/configs/ateb9200_defconfig
 delete mode 100644 arch/arm/configs/carmeva_defconfig
 delete mode 100644 arch/arm/configs/cpuat91_defconfig
 delete mode 100644 arch/arm/configs/csb337_defconfig
 delete mode 100644 arch/arm/configs/csb637_defconfig
 delete mode 100644 arch/arm/configs/ecbat91_defconfig
 delete mode 100644 arch/arm/configs/kafa_defconfig
 delete mode 100644 arch/arm/configs/kb9202_defconfig
 delete mode 100644 arch/arm/configs/onearm_defconfig
 delete mode 100644 arch/arm/configs/picotux200_defconfig
 delete mode 100644 arch/arm/configs/yl9200_defconfig
 rename arch/arm/mach-at91/{board-dk.c => board-rm9200dk.c} (98%)
 rename arch/arm/mach-at91/{board-ek.c => board-rm9200ek.c} (98%)

Thanks, best regards,
-- 
Nicolas Ferre
