From: andrea.adami@gmail.com (Andrea Adami)
Date: Mon, 14 Aug 2017 22:48:31 +0200
Subject: [PATCH v5 0/9] mtd: sharpslpart partition parser
Message-ID: <1502743720-28672-1-git-send-email-andrea.adami@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset introduces a simple partition parser for the Sharp SL
Series PXA handhelds. More details in the commit text.

I have set in cc the ARM PXA maintainers because this is the MTD part of
a planned wider patchset cleaning the Zaurus board files. The MFD maintainers
are also in cc (tmio.h change).

Changelog:
v1 firt version, initial import of 2.4 sources
v2 refactor applying many suggested fixes
v3 put the partition parser types in the platform data
v4 refactor after ML review
v5 fix commit messages and subject texts, remove global, fixes after v4 review

GPL sources: http://support.ezaurus.com/developer/source/source_dl.asp

Andrea Adami (9):
  mtd: sharpslpart: Add sharpslpart partition parser
  mtd: nand: sharpsl: Add partition parsers platform data
  mfd: tmio: Add partition parsers platform data
  mtd: nand: sharpsl: Register partitions using the parsers
  mtd: nand: tmio: Register partitions using the parsers
  ARM: pxa/corgi: Remove hardcoded partitioning, use sharpslpart parser
  ARM: pxa/tosa: Remove hardcoded partitioning, use sharpslpart parser
  ARM: pxa/spitz: Remove hardcoded partitioning, use sharpslpart parser
  ARM: pxa/poodle: Remove hardcoded partitioning, use sharpslpart parser

 arch/arm/mach-pxa/corgi.c         |  31 +---
 arch/arm/mach-pxa/poodle.c        |  28 +--
 arch/arm/mach-pxa/spitz.c         |  34 +---
 arch/arm/mach-pxa/tosa.c          |  28 +--
 drivers/mtd/nand/sharpsl.c        |   2 +-
 drivers/mtd/nand/tmio_nand.c      |   4 +-
 drivers/mtd/parsers/Kconfig       |   8 +
 drivers/mtd/parsers/Makefile      |   1 +
 drivers/mtd/parsers/sharpslpart.c | 376 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/tmio.h          |   1 +
 include/linux/mtd/sharpsl.h       |   1 +
 11 files changed, 424 insertions(+), 90 deletions(-)
 create mode 100644 drivers/mtd/parsers/sharpslpart.c

-- 
2.7.4
