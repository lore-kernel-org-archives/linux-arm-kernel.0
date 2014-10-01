From: rogerq@ti.com (Roger Quadros)
Date: Wed, 1 Oct 2014 14:33:28 +0300
Subject: [PATCH 0/2] mtd: nand: omap: Fix build with CONFIG_MTD_NAND_OMAP_BCH=m
Message-ID: <1412163210-12948-1-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Patch 1 fixes build with OMAP nand driver as built-in and the BCH driver as a module.
Ezequiel, I took the liberty to address an issue with your original patch so this is v2.

Patch 2 fixes the help message for CONFIG_MTD_NAND_OMAP_BCH to avoid user confusion.
CONFIG_MTD_NAND_OMAP_BCH is optional but doesn't harm on legacy OMAP platforms not having
the ELM/BCH hardware.

--
cheers,
-roger

Ezequiel Garcia (1):
  mtd: nand: Force omap_elm to be built as a module if omap2_nand is a
    module

Roger Quadros (1):
  mtd: nand: omap: Correct CONFIG_MTD_NAND_OMAP_BCH help message

 drivers/mtd/nand/Kconfig  | 7 +++++--
 drivers/mtd/nand/Makefile | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
1.8.3.2
