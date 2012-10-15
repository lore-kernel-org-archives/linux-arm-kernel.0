From: hdk@igel.co.jp (Hideki EIRAKU)
Date: Mon, 15 Oct 2012 17:34:51 +0900
Subject: [PATCH v4 0/2] Renesas IPMMU driver for sh7372
Message-ID: <1350290093-998-1-git-send-email-hdk@igel.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the Renesas IPMMU driver, IOMMU API implementation and IPMMU
device support for sh7372 (AP4EVB and Mackerel).

The IPMMU module supports the MMU function and the PMB function.  The
MMU function provides address translation by pagetable compatible with
ARMv6.  The PMB function provides address translation including
tile-linear translation.  This is implementation of the MMU function.

v4:
- Rebased on 3.7-rc1.
- Use address space size instead of page table size in config.
- Use Kconfig default value instead of #ifdef-#define-#endif.
v3:
- Rebased on 3.6-rc5.
- Simplify configs.  SHMOBILE_IPMMU is now selected by setting
  SHMOBILE_IOMMU.
- Remove weak symbols.
- Use drvdata to store private driver data.
- Make a function for writing to a register of IPMMU.
- Add a lock to accessing the tlb_enabled member.
- Make unmap work correctly with size larger than map size.
- Free L2 page table when 1MiB page is mapped or unmapped.
- Add VEU devices as IP blocks on the ICB.
v2:
- Rebased on v3.6-rc1.
- Make variable names clear.
- Page table size can now be selected by config.

Hideki EIRAKU (2):
  iommu/shmobile: Add iommu driver for Renesas IPMMU modules
  ARM: mach-shmobile: sh7372: Add IPMMU device

 arch/arm/mach-shmobile/Kconfig              |    6 +
 arch/arm/mach-shmobile/Makefile             |    3 +
 arch/arm/mach-shmobile/board-ap4evb.c       |    5 +
 arch/arm/mach-shmobile/board-mackerel.c     |    5 +
 arch/arm/mach-shmobile/include/mach/ipmmu.h |   16 ++
 arch/arm/mach-shmobile/ipmmu.c              |  150 ++++++++++++
 arch/arm/mach-shmobile/setup-sh7372.c       |   26 ++
 drivers/iommu/Kconfig                       |   56 +++++
 drivers/iommu/Makefile                      |    1 +
 drivers/iommu/shmobile-iommu.c              |  352 +++++++++++++++++++++++++++
 10 files changed, 620 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/include/mach/ipmmu.h
 create mode 100644 arch/arm/mach-shmobile/ipmmu.c
 create mode 100644 drivers/iommu/shmobile-iommu.c
