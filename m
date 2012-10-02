From: hechtb@googlemail.com (Bastian Hecht)
Date: Tue,  2 Oct 2012 15:12:00 +0200
Subject: [PATCH 0/2] Add DMA and device tree support to the flash controller
 FLCTL
Message-ID: <1349183522-15321-1-git-send-email-hechtb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This mini-series consists of 2 separately posted patch-sets that shrunk
to one patch each. It adds DMA support for the data part (not ECC) as
well as device tree support to the FLCTL flash controller.
As the 2nd patch is based on the 1st, I've decided to
collect them here to avoid any confusion.

The first set contained
[PATCH 1/2] mtd: sh_flctl: Setup and release DMA channels
[PATCH 2/2] mtd: sh_flctl: Use DMA for data fifo FLTDFIFO when available
and was merged after 2 reviews to
[PATCH] mtd: sh_flctl: Add DMA capabilty (same patch as in here)

The second set contained
[PATCH 1/3] mtd: sh_flctl: Probe SNAND_E flag from NAND chip
[PATCH 2/3] mtd: sh_flctl: Add device tree support
[PATCH 3/3] mtd: sh_flctl: Add sh7372 device tree config
and is merged here to
mtd: sh_flctl: Add device tree support

Patch 1 can be omitted as SNAND_E is handled in the FLCTL source anyway
correctly in set_cmd_regs() and the flag can be removed from existing board
codes without this patch.
Patch 2 without patch 3 may be confusing so I merged them too. Documentation
is added as well.

I've added linux-arm-kernel at lists.infradead.org as recipient for the
device tree part.

The patchset is based on
l2-mtd	git://git.infradead.org/users/dedekind/l2-mtd.git
with reverted commit e26c113b4130aefa1d8446602bb5b05cfd646bfe.


Bastian Hecht (2):
  mtd: sh_flctl: Add DMA capabilty
  mtd: sh_flctl: Add device tree support

 .../devicetree/bindings/mtd/flctl-nand.txt         |   37 +++
 drivers/mtd/nand/sh_flctl.c                        |  266 +++++++++++++++++++-
 include/linux/mtd/sh_flctl.h                       |   12 +
 3 files changed, 305 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/flctl-nand.txt

-- 
1.7.5.4
