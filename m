From: hdk@igel.co.jp (Hideki EIRAKU)
Date: Thu, 16 Aug 2012 16:42:02 +0900
Subject: [PATCH v2 0/2] Renesas IPMMU driver for sh7372
Message-ID: <1345102924-22045-1-git-send-email-hdk@igel.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the Renesas IPMMU driver, IOMMU API implementation and IPMMU
device support for sh7372 (AP4EVB and Mackerel).

The IPMMU module supports the MMU function and the PMB function.  The
MMU function provides address translation by pagetable compatible with
ARMv6.  The PMB function provides address translation including
tile-linear translation.  This is implementation of the MMU function.

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
 arch/arm/mach-shmobile/include/mach/ipmmu.h |   10 +
 arch/arm/mach-shmobile/ipmmu.c              |  130 ++++++++++
 arch/arm/mach-shmobile/setup-sh7372.c       |   22 ++
 drivers/iommu/Kconfig                       |   35 +++
 drivers/iommu/Makefile                      |    1 +
 drivers/iommu/shmobile-iommu.c              |  342 +++++++++++++++++++++++++++
 10 files changed, 559 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/include/mach/ipmmu.h
 create mode 100644 arch/arm/mach-shmobile/ipmmu.c
 create mode 100644 drivers/iommu/shmobile-iommu.c
