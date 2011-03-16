From: b32955@freescale.com (Huang Shijie)
Date: Wed, 16 Mar 2011 09:55:14 +0800
Subject: [PATCH 0/7] add the GPMI controller driver for IMX23/IMX28
Message-ID: <1300240521-4344-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The general-purpose media interface(GPMI) controller is a flexible interface
to up to several NAND flashs.

The Bose Ray-Choudhury Hocquenghem(BCH) module is a hardware ECC accelerator.

With the help of BCH, the GPMI controller can choose to do the hardware ECC or
not.

This driver is based the Shawn Guo's DMA patches for IMX23/IMX28,
please refer to :
	http://git.infradead.org/users/vkoul/slave-dma.git/commit/a580b8c5429a624d120cd603e1498bf676e2b4da

add the mtd maillist.	

Huang Shijie (7):
  ARM: add GPMI support for imx23/imx28
  add the common code for GPMI driver
  add the database for the NANDs
  add GPMI support for imx23
  add GPMI support for imx28
  dmaengine: change the flags of request_irq()
  MTD : add GPMI driver in the config and Makefile

 arch/arm/mach-mxs/Kconfig                       |    2 +
 arch/arm/mach-mxs/clock-mx23.c                  |    3 +
 arch/arm/mach-mxs/clock-mx28.c                  |    3 +
 arch/arm/mach-mxs/devices-mx23.h                |    3 +
 arch/arm/mach-mxs/devices-mx28.h                |    3 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-gpmi.c       |  144 +++
 arch/arm/mach-mxs/include/mach/devices-common.h |    4 +
 arch/arm/mach-mxs/include/mach/gpmi-nfc.h       |   75 ++
 arch/arm/mach-mxs/mach-mx23evk.c                |   37 +
 arch/arm/mach-mxs/mach-mx28evk.c                |   37 +
 drivers/dma/mxs-dma.c                           |    2 +-
 drivers/mtd/nand/Kconfig                        |   10 +
 drivers/mtd/nand/Makefile                       |    1 +
 drivers/mtd/nand/gpmi-nfc/Makefile              |   10 +
 drivers/mtd/nand/gpmi-nfc/bch-regs-imx23.h      |  550 +++++++++++
 drivers/mtd/nand/gpmi-nfc/bch-regs-imx28.h      |  557 ++++++++++++
 drivers/mtd/nand/gpmi-nfc/gpmi-nfc-main.c       |  524 +++++++++++
 drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h            |  520 +++++++++++
 drivers/mtd/nand/gpmi-nfc/gpmi-regs-imx23.h     |  416 +++++++++
 drivers/mtd/nand/gpmi-nfc/gpmi-regs-imx28.h     |  421 +++++++++
 drivers/mtd/nand/gpmi-nfc/hal-common.c          |  816 +++++++++++++++++
 drivers/mtd/nand/gpmi-nfc/hal-imx23.c           |  556 ++++++++++++
 drivers/mtd/nand/gpmi-nfc/hal-imx28.c           |  503 +++++++++++
 drivers/mtd/nand/gpmi-nfc/mil.c                 | 1104 +++++++++++++++++++++++
 drivers/mtd/nand/gpmi-nfc/nand_device_info.c    |  181 ++++
 drivers/mtd/nand/gpmi-nfc/nand_device_info.h    |  145 +++
 drivers/mtd/nand/gpmi-nfc/rom-common.c          |   48 +
 drivers/mtd/nand/gpmi-nfc/rom-imx23.c           |  300 ++++++
 drivers/mtd/nand/gpmi-nfc/rom-imx28.c           |   66 ++
 31 files changed, 7044 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-gpmi.c
 create mode 100644 arch/arm/mach-mxs/include/mach/gpmi-nfc.h
 create mode 100644 drivers/mtd/nand/gpmi-nfc/Makefile
 create mode 100644 drivers/mtd/nand/gpmi-nfc/bch-regs-imx23.h
 create mode 100644 drivers/mtd/nand/gpmi-nfc/bch-regs-imx28.h
 create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-nfc-main.c
 create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h
 create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-regs-imx23.h
 create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-regs-imx28.h
 create mode 100644 drivers/mtd/nand/gpmi-nfc/hal-common.c
 create mode 100644 drivers/mtd/nand/gpmi-nfc/hal-imx23.c
 create mode 100644 drivers/mtd/nand/gpmi-nfc/hal-imx28.c
 create mode 100644 drivers/mtd/nand/gpmi-nfc/mil.c
 create mode 100644 drivers/mtd/nand/gpmi-nfc/nand_device_info.c
 create mode 100644 drivers/mtd/nand/gpmi-nfc/nand_device_info.h
 create mode 100644 drivers/mtd/nand/gpmi-nfc/rom-common.c
 create mode 100644 drivers/mtd/nand/gpmi-nfc/rom-imx23.c
 create mode 100644 drivers/mtd/nand/gpmi-nfc/rom-imx28.c
