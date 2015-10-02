From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 2 Oct 2015 23:26:41 +0530
Subject: [PATCH 0/5] NAND support for Broadcom NS2 SoC
Message-ID: <1443808606-21203-1-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We enable NAND support for Broadcom NS2 SoC by reusing existing
BRCMNAND driver.

This patchset applies on-top of "arm64: Simple additions to
NS2 DT" patchset and is available in ns2_nand_v1 branch of 
https://github.com/Broadcom/arm64-linux.git.

The patchset is tested on NS2 SVK.

Anup Patel (5):
  mtd: brcmnand: Fix pointer type-cast in brcmnand_write()
  mtd: nand: Allow MTD_NAND_BRCMNAND to be selected for ARM64
  mtd: brcmnand: Optional DT flag to reset IPROC NAND controller
  Documentation: dt-bindings: Add info about brcm,nand-iproc-reset DT
    flag
  arm64: dts: Add BRCM IPROC NAND DT node for NS2

 .../devicetree/bindings/mtd/brcm,brcmnand.txt         |  4 ++++
 arch/arm64/boot/dts/broadcom/ns2-svk.dts              | 12 ++++++++++++
 arch/arm64/boot/dts/broadcom/ns2.dtsi                 | 15 +++++++++++++++
 drivers/mtd/nand/Kconfig                              |  2 +-
 drivers/mtd/nand/brcmnand/brcmnand.c                  |  4 ++--
 drivers/mtd/nand/brcmnand/iproc_nand.c                | 19 +++++++++++++++++++
 6 files changed, 53 insertions(+), 3 deletions(-)

-- 
1.9.1
