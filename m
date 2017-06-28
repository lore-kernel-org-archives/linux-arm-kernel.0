From: andrea.adami@gmail.com (Andrea Adami)
Date: Wed, 28 Jun 2017 22:30:27 +0200
Subject: [PATCH v4 0/9] mtd: sharpslpart partition parser
Message-ID: <1498681836-3765-1-git-send-email-andrea.adami@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset introduces a simple partition parser for the Sharp SL
Series PXA handhelds. More details in the commit text.

I have set in cc the ARM PXA maintainers because this is the MTD part of
a planned wider patchset cleaning the Zaurus board files. The MFD maintainers
are also in cc (tmio.h change).

Changelog:
v1 initial import of 2.4 sources [1]
v2 refactor applying many suggested fixes [2]
v3 put the partition parser types in the platform data [3]
v4 refactor after ML review [4]

[1] http://support.ezaurus.com/developer/source/source_dl.asp
[2] https://github.com/LinuxPDA/linux/commits/sharpslpart_v2
[3] https://github.com/LinuxPDA/linux/commits/sharpslpart_v3
[4] https://github.com/LinuxPDA/linux/commits/sharpslpart_v4

Andrea Adami (9):
  mtd: sharpslpart: add sharpslpart MTD partition parser
  mtd: nand: sharpsl.h: support partition parser types
  mfd: tmio.h: support partition parser types
  mtd: nand: sharpsl.c: take in account partition parser types
  mtd: nand: tmio_nand.c: take in account partition parser types
  ARM: pxa: corgi.c: remove hardcoded partitioning, use sharpslpart
    parser
  ARM: pxa: tosa.c: remove hardcoded partitioning, use sharpslpart
    parser
  ARM: pxa: spitz.c: remove hardcoded partitioning, use sharpslpart
    parser
  ARM: pxa: poodle.c: remove hardcoded partitioning, use sharpslpart
    parser

 arch/arm/mach-pxa/corgi.c    |  31 +---
 arch/arm/mach-pxa/poodle.c   |  28 +---
 arch/arm/mach-pxa/spitz.c    |  34 +---
 arch/arm/mach-pxa/tosa.c     |  28 +---
 drivers/mtd/Kconfig          |   8 +
 drivers/mtd/Makefile         |   1 +
 drivers/mtd/nand/sharpsl.c   |   2 +-
 drivers/mtd/nand/tmio_nand.c |   4 +-
 drivers/mtd/sharpslpart.c    | 391 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/tmio.h     |   1 +
 include/linux/mtd/sharpsl.h  |   1 +
 11 files changed, 439 insertions(+), 90 deletions(-)
 create mode 100644 drivers/mtd/sharpslpart.c

-- 
2.7.4
