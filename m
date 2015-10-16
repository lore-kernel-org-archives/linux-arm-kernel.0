From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 16 Oct 2015 14:38:53 +0530
Subject: [PATCH v2 0/4] NAND support for Broadcom NS2 SoC
Message-ID: <1444986537-28387-1-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We enable NAND support for Broadcom NS2 SoC by reusing existing
BRCMNAND driver.

This patchset applies on-top of "arm64: Simple additions to
NS2 DT" v1 patchset and is available in ns2_nand_v2 branch of
https://github.com/Broadcom/arm64-linux.git.

The patchset is tested on NS2 SVK.

Changes since v1:
 - Dropped patch3 and patch4 because we don't need to reset
   BRCMNAND controller for NS2.
 - Added patch to force 8bit mode before doing nand_scan_ident()
   in brcmnand_init_cs().

Anup Patel (4):
  mtd: brcmnand: Fix pointer type-cast in brcmnand_write()
  mtd: nand: Allow MTD_NAND_BRCMNAND to be selected for ARM64
  mtd: brcmnand: Force 8bit mode before doing nand_scan_ident()
  arm64: dts: Add BRCM IPROC NAND DT node for NS2

 arch/arm64/boot/dts/broadcom/ns2-svk.dts | 12 ++++++++++++
 arch/arm64/boot/dts/broadcom/ns2.dtsi    | 14 ++++++++++++++
 drivers/mtd/nand/Kconfig                 |  2 +-
 drivers/mtd/nand/brcmnand/brcmnand.c     | 13 +++++++++++--
 4 files changed, 38 insertions(+), 3 deletions(-)

-- 
1.9.1
