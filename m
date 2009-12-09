From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 10 Dec 2009 00:11:13 +0530
Subject: [PATCH 0/4] OMAP4: Enable L2 cache
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BC0A824C@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony, Russell,

This series is based on top of earlier series [1] and generated against latest
Mainline. This enables the L2 cache support on OMAP4430 SDP platform.

[1] http://patchwork.kernel.org/patch/66028/
"[PATCH 0/6] OMAP4: update series"

The Errata patch [PATCH 3/4] may need to be streamlined bit since it's touching
generic code. I didn't find a better way to patch this.

Thanks for the review !!

---
Santosh Shilimkar (4):
      OMAP4: Add L2 Cache support
      OMAP4: Clean the secondary_data from L2
      ARM: L2 : Errata 588369: Clean & Invalidate do not invalidate clean lines
      OMAP4: Enable L2 Cache

 arch/arm/Kconfig                           |   13 +++++++++++
 arch/arm/configs/omap_4430sdp_defconfig    |    3 ++
 arch/arm/mach-omap2/board-4430sdp.c        |   30 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap-smp.c             |    2 +
 arch/arm/mm/Kconfig                        |    2 +-
 arch/arm/mm/cache-l2x0.c                   |   32 ++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap44xx.h |    1 +
 7 files changed, 82 insertions(+), 1 deletions(-)

Regards,
Santosh 
