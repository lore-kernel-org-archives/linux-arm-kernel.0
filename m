From: leiwen@marvell.com (Lei Wen)
Date: Tue, 28 Jun 2011 20:51:25 -0700
Subject: [PATCH V3 0/9] pxa3xx_nand: add two chip select support
In-Reply-To: <1309246361.23597.30.camel@sauron>
References: <1309246361.23597.30.camel@sauron>
Message-ID: <1309319494-17951-1-git-send-email-leiwen@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

V2:
Choose to at most keep original pxa3xx_nand_info structure to reduce
patch size

V3:
Seperate original one patch into a patch set

Lei Wen (9):
  MTD: pxa3xx_nand: convert all printk into dev_*
  MTD: pxa3xx_nand: enable multiple chip select support
  ARM: aspenite: fix nand platform data
  ARM: cm-x300: fix nand platform data
  ARM: colibri-pxa3xx: fix nand platform data
  ARM: littleton: fix nand platform data
  ARM: mxm8x10: fix nand platform data
  ARM: raumfeld: fix nand platform data
  ARM: zylonite: fix nand platform data

 arch/arm/mach-mmp/aspenite.c                 |    5 +-
 arch/arm/mach-pxa/cm-x300.c                  |    5 +-
 arch/arm/mach-pxa/colibri-pxa3xx.c           |    5 +-
 arch/arm/mach-pxa/littleton.c                |    5 +-
 arch/arm/mach-pxa/mxm8x10.c                  |    9 +-
 arch/arm/mach-pxa/raumfeld.c                 |    5 +-
 arch/arm/mach-pxa/zylonite.c                 |    5 +-
 arch/arm/plat-pxa/include/plat/pxa3xx_nand.h |   19 +-
 drivers/mtd/nand/pxa3xx_nand.c               |  512 +++++++++++++++-----------
 9 files changed, 346 insertions(+), 224 deletions(-)
