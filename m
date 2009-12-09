From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 9 Dec 2009 23:54:59 +0530
Subject: [PATCH 0/6] OMAP4: update series
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BC0A8247@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony, Russell,

This series has fixes for OMAP4430 and generated against latest mainline kernel. The 
series is tested on OMAP4430SDP ES1.0 silicon 
It's needs an UART related patch which is in your(Tony's) queue.

Please review the same.

The following changes since commit 2588465badb648a50cd19623f0dd0063c90d4e31:
  Linus Torvalds (1):
        Merge branch 'bkl-arch-for-linus' of git://git.kernel.org/.../tip/linux-2.6-tip

Santosh Shilimkar (6):
      OMAP4: Fix cpu detection
      OMAP4: Fix SRAM base and size
      OMAP4: Re-arrange the low level debug code
      OMAP4: AuxCoreBoot registers only accessible in secure mode.
      OMAP4: Remove the secondary wait loop.
      OMAP4: Sync up omap4430 defconfig

 arch/arm/configs/omap_4430sdp_defconfig        |  146 ++++++++++++++----------
 arch/arm/mach-omap2/id.c                       |   27 ++++-
 arch/arm/mach-omap2/include/mach/debug-macro.S |   13 ++-
 arch/arm/mach-omap2/omap-headsmp.S             |   35 +++++--
 arch/arm/mach-omap2/omap-smp.c                 |   31 ++----
 arch/arm/plat-omap/common.c                    |    2 +-
 arch/arm/plat-omap/include/plat/cpu.h          |    3 +-
 arch/arm/plat-omap/include/plat/smp.h          |    2 +
 arch/arm/plat-omap/sram.c                      |   12 ++-
 9 files changed, 171 insertions(+), 100 deletions(-)

Regards,
Santosh 
