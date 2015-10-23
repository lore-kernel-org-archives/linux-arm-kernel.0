From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 23 Oct 2015 10:46:11 +0530
Subject: [PATCH v3 0/2] NAND support for Broadcom NS2 SoC
Message-ID: <1445577373-21252-1-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We enable NAND support for Broadcom NS2 SoC by reusing existing
BRCMNAND driver.

This patchset applies on-top of "arm64: Simple additions to
NS2 DT" v1 patchset and is available in ns2_nand_v3 branch of
https://github.com/Broadcom/arm64-linux.git.

The patchset is tested on NS2 SVK.

Changes since v2:
 - Dropped patch1 and patch2 because these are already merged
   by MTD maintainer.
 - Avoid using absolute node paths in ns2-svk.dts.

Changes since v1:
 - Dropped patch3 and patch4 because we don't need to reset
   BRCMNAND controller for NS2.
 - Added patch to force 8bit mode before doing nand_scan_ident()
   in brcmnand_init_cs().

Anup Patel (2):
  mtd: brcmnand: Force 8bit mode before doing nand_scan_ident()
  arm64: dts: Add BRCM IPROC NAND DT node for NS2

 arch/arm64/boot/dts/broadcom/ns2-svk.dts | 30 ++++++++++++++++++++----------
 arch/arm64/boot/dts/broadcom/ns2.dtsi    | 14 ++++++++++++++
 drivers/mtd/nand/brcmnand/brcmnand.c     |  9 +++++++++
 3 files changed, 43 insertions(+), 10 deletions(-)

-- 
1.9.1
