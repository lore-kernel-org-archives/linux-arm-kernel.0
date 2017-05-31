From: andrea.adami@gmail.com (Andrea Adami)
Date: Thu,  1 Jun 2017 00:40:49 +0200
Subject: [PATCH v3 0/9] mtd: sharpslpart partition parser
Message-ID: <1496270458-6479-1-git-send-email-andrea.adami@gmail.com>
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
v3 put the partition parser types in the platform data

[1] https://github.com/LinuxPDA/Sharp_FTL_2.4.20
[2] https://github.com/LinuxPDA/linux/commits/sharpslpart_v2

Andrea Adami (9):
  mtd: sharpslpart: add sharpslpart MTD partition parser
  mtd: nand: sharpsl.h: support partition parser types
  mfd: nand: tmio.h: support partition parser types
  mtd: nand: sharpsl.c: take in account partition parser types
  mtd: nand: tmio_nand.c: take in account partition parser types
  arm: pxa: corgi.c: remove hardcoded partitioning, use sharpslpart
    parser
  arm: pxa: tosa.c: remove hardcoded partitioning, use sharpslpart
    parser
  arm: pxa: spitz.c: remove hardcoded partitioning, use sharpslpart
    parser
  arm: pxa: poodle.c: remove hardcoded partitioning, use sharpslpart
    parser

 arch/arm/mach-pxa/corgi.c    |  31 ++-----
 arch/arm/mach-pxa/poodle.c   |  28 ++----
 arch/arm/mach-pxa/spitz.c    |  34 ++-----
 arch/arm/mach-pxa/tosa.c     |  28 ++----
 drivers/mtd/Kconfig          |   8 ++
 drivers/mtd/Makefile         |   2 +
 drivers/mtd/nand/sharpsl.c   |   9 +-
 drivers/mtd/nand/tmio_nand.c |   4 +-
 drivers/mtd/sharpsl_ftl.c    | 216 +++++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/sharpsl_ftl.h    |  34 +++++++
 drivers/mtd/sharpslpart.c    | 132 ++++++++++++++++++++++++++
 include/linux/mfd/tmio.h     |   1 +
 include/linux/mtd/sharpsl.h  |   1 +
 13 files changed, 437 insertions(+), 91 deletions(-)
 create mode 100644 drivers/mtd/sharpsl_ftl.c
 create mode 100644 drivers/mtd/sharpsl_ftl.h
 create mode 100644 drivers/mtd/sharpslpart.c

-- 
2.7.4
