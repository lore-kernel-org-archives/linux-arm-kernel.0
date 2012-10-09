From: vipin.kumar@st.com (Vipin Kumar)
Date: Tue, 9 Oct 2012 16:14:42 +0530
Subject: [PATCH 00/11] mtd/nand: fsmc driver updates
Message-ID: <cover.1349778820.git.vipin.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set contains several fixes and a few enhancements in fsmc driver.
Modifications include
- General enhancements
  * Add ready/busy support through a GPIO pin
  * Add software bch support
  * Increase ecc loactions to 640
  * Support multiple banks
  * Use relaxed io accessors for increased throughput
- Enhance DT support
  * Add timing parameters
- Several fixes
  * Fix the type for regs
  * Replace change_bit routine to handle unaligned addresses
  * Provide contiguous buffers for DMA operation

Vipin Kumar (11):
  fsmc/nand:FIX: Change the type for regs to void __iomem *
  fsmc/nand: Rearrange the fsmc_nand_data structure and update comments
  fsmc/nand: Support multiple banks connected to controller
  fsmc/nand: Accept nand timing parameters via DT
  fsmc: Implement ready/busy through gpio pin
  fsmc/nand: Modify the wait to uninterruptible
  fsmc/nand: Provide contiguous buffers to dma
  fsmc/nand: Use relaxed variants of io accessors
  fsmc/nand:FIX: replace change_bit routine
  fsmc/nand: Add sw bch support for ecc calculation/correction
  nand: Increase the ecc placement locations to 640

 .../devicetree/bindings/mtd/fsmc-nand.txt          |  29 ++
 arch/arm/boot/dts/spear300.dtsi                    |   1 +
 arch/arm/boot/dts/spear310.dtsi                    |   1 +
 arch/arm/boot/dts/spear320.dtsi                    |   1 +
 arch/arm/boot/dts/spear600.dtsi                    |   1 +
 arch/arm/mach-u300/core.c                          |   1 +
 drivers/mtd/nand/fsmc_nand.c                       | 419 ++++++++++++++-------
 include/linux/mtd/fsmc.h                           |  18 +-
 include/linux/mtd/mtd.h                            |   2 +-
 9 files changed, 332 insertions(+), 141 deletions(-)

-- 
1.7.11.4
