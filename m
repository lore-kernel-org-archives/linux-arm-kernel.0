From: b32955@freescale.com (Huang Shijie)
Date: Wed, 24 Aug 2011 15:07:19 +0800
Subject: [PATCH v8 0/4] add the GPMI-NAND support for imx23/imx28
Message-ID: <1314169643-23425-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch set is based on tag v3.1-rc2 of linus's tree.
and it can be git-am to Artem's tree:
	http://git.infradead.org/users/dedekind/l2-mtd-2.6.git

The general-purpose media interface(GPMI) controller is a flexible interface
to up to several NAND flashs.

The Bose Ray-Choudhury Hocquenghem(BCH) module is a hardware ECC accelerator.

With the help of BCH, the GPMI controller can choose to do the hardware ECC or
not.

v7 --> v8:
	[0] add header file to fix compiling error.

v6 --> v7:
	[0] rename RES_SIZE to GPMI_NAND_RES_SIZE.
	[1] move gpmi-nand.h to `include/linux/mtd/` directory.
	[2] remove comment for new pad control.
	[3] others

v5 --> v6:
	[0] rename `gpmi-nfc` to `gpmi-nand`.
	[1] remove ->exit() in structure gpmi_nand_platform_data{}.
	[2] drop the macros for the resource's definition of gpmi-nand.
	[3] add a new pad control `MXS_PAD_CTRL_12MA`. 
	[4] others.

v4 --> v5:
	[0] split out the mach code and the machine code.

v3 --> v4:
	merge the GPMI-NFC device code to the new branch.

Huang Shijie (4):
  ARM: mxs: add GPMI-NAND support for imx23/imx28
  ARM: mxs: add new a pad control
  ARM: mxs/mx23evk: add GPMI-NAND device
  ARM: mxs/mx28evk: add GPMI-NAND device

 arch/arm/mach-mxs/Kconfig                       |    2 +
 arch/arm/mach-mxs/clock-mx23.c                  |    1 +
 arch/arm/mach-mxs/clock-mx28.c                  |    1 +
 arch/arm/mach-mxs/devices-mx23.h                |    4 +
 arch/arm/mach-mxs/devices-mx28.h                |    4 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-gpmi-nand.c  |  109 +++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/devices-common.h |   10 ++
 arch/arm/mach-mxs/include/mach/iomux.h          |    1 +
 arch/arm/mach-mxs/mach-mx23evk.c                |   36 ++++++++
 arch/arm/mach-mxs/mach-mx28evk.c                |   36 ++++++++
 include/linux/mtd/gpmi-nand.h                   |   68 ++++++++++++++
 13 files changed, 276 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-gpmi-nand.c
 create mode 100644 include/linux/mtd/gpmi-nand.h
