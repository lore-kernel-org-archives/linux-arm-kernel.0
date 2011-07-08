From: leiwen@marvell.com (Lei Wen)
Date: Thu,  7 Jul 2011 20:34:41 -0700
Subject: [PATCH V5 0/3] pxa3xx_nand: add two chip select support
In-Reply-To: <1309771536-10597-1-git-send-email-leiwen@marvell.com>
References: <1309771536-10597-1-git-send-email-leiwen@marvell.com>
Message-ID: <1310096084-14646-1-git-send-email-leiwen@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

V2:
Choose to at most keep original pxa3xx_nand_info structure to reduce
patch size

V3:
Seperate original one patch into a patch set

V4:
Further seperate patch into small pieces:
Mainly change make in two patch, which seperate do
the new structure definition and two chip select support add.

V5:
Merge platform change patch and two chip feature into one patch.
Clean some format issue.

Lei Wen (3):
  MTD: pxa3xx_nand: convert all printk into dev_*
  MTD: pxa3xx_nand: sperate each chip individual info
  MTD: pxa3xx_nand: enable multiple chip select support

 arch/arm/mach-mmp/aspenite.c                 |    5 +-
 arch/arm/mach-pxa/cm-x300.c                  |    5 +-
 arch/arm/mach-pxa/colibri-pxa3xx.c           |    5 +-
 arch/arm/mach-pxa/littleton.c                |    5 +-
 arch/arm/mach-pxa/mxm8x10.c                  |    9 +-
 arch/arm/mach-pxa/raumfeld.c                 |    5 +-
 arch/arm/mach-pxa/zylonite.c                 |    5 +-
 arch/arm/plat-pxa/include/plat/pxa3xx_nand.h |   20 ++-
 drivers/mtd/nand/pxa3xx_nand.c               |  419 ++++++++++++++++----------
 9 files changed, 298 insertions(+), 180 deletions(-)
