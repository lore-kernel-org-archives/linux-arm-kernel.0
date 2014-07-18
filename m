From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 18 Jul 2014 18:05:16 -0400
Subject: [GIT PULL] ARM: mvebu: SoC changes for v3.17 (round 2)
Message-ID: <20140718220516.GM24496@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

Yeah, it's just one patch, but it's a beautiful one!  Thanks to the
efforts of many people over the last couple years, and in particular,
Andrew Lunn, Kirkwood has been completely converted to DT.

As usual, this is an incremental pull request from tags/mvebu-soc-3.17
up to tags/mvebu-soc-3.17-2 on the mvebu/soc branch.

Please pull.

thx,

Jason.


The following changes since commit e65714740d65237c40878b63acad6bf921481974:

  ARM: mvebu: Staticize mvebu_cpu_reset_init (2014-06-30 17:41:04 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-3.17-2

for you to fetch changes up to ba364fc752daeded072a5ef31e43b84cb1f9e5fd:

  ARM: Kirkwood: Remove mach-kirkwood (2014-07-13 22:13:39 +0000)

----------------------------------------------------------------
mvebu SoC changes for v3.17 (round 2)

 - kirkwood
   - Remove mach-kirkwood/, It's fully supported in mach-mvebu/

----------------------------------------------------------------
Andrew Lunn (1):
      ARM: Kirkwood: Remove mach-kirkwood

 arch/arm/Kconfig                                  |  18 -
 arch/arm/Kconfig.debug                            |   5 +-
 arch/arm/Makefile                                 |   1 -
 arch/arm/boot/dts/Makefile                        |   5 +-
 arch/arm/mach-kirkwood/Kconfig                    | 111 ----
 arch/arm/mach-kirkwood/Makefile                   |  14 -
 arch/arm/mach-kirkwood/Makefile.boot              |   3 -
 arch/arm/mach-kirkwood/board-dt.c                 | 223 -------
 arch/arm/mach-kirkwood/common.c                   | 746 ----------------------
 arch/arm/mach-kirkwood/common.h                   |  74 ---
 arch/arm/mach-kirkwood/d2net_v2-setup.c           | 231 -------
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h |  86 ---
 arch/arm/mach-kirkwood/include/mach/entry-macro.S |  34 -
 arch/arm/mach-kirkwood/include/mach/hardware.h    |  14 -
 arch/arm/mach-kirkwood/include/mach/irqs.h        |  65 --
 arch/arm/mach-kirkwood/include/mach/kirkwood.h    | 142 ----
 arch/arm/mach-kirkwood/include/mach/uncompress.h  |  46 --
 arch/arm/mach-kirkwood/irq.c                      |  82 ---
 arch/arm/mach-kirkwood/lacie_v2-common.c          | 114 ----
 arch/arm/mach-kirkwood/lacie_v2-common.h          |  16 -
 arch/arm/mach-kirkwood/mpp.c                      |  43 --
 arch/arm/mach-kirkwood/mpp.h                      | 348 ----------
 arch/arm/mach-kirkwood/netxbig_v2-setup.c         | 422 ------------
 arch/arm/mach-kirkwood/openrd-setup.c             | 255 --------
 arch/arm/mach-kirkwood/pcie.c                     | 296 ---------
 arch/arm/mach-kirkwood/pm.c                       |  76 ---
 arch/arm/mach-kirkwood/pm.h                       |  26 -
 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c      |  89 ---
 arch/arm/mach-kirkwood/rd88f6281-setup.c          | 128 ----
 arch/arm/mach-kirkwood/t5325-setup.c              | 216 -------
 arch/arm/mach-kirkwood/ts219-setup.c              | 142 ----
 arch/arm/mach-kirkwood/ts41x-setup.c              | 186 ------
 arch/arm/mach-kirkwood/tsx1x-common.c             | 113 ----
 arch/arm/mach-kirkwood/tsx1x-common.h             |   7 -
 arch/arm/mm/Kconfig                               |   2 +-
 35 files changed, 4 insertions(+), 4375 deletions(-)
 delete mode 100644 arch/arm/mach-kirkwood/Kconfig
 delete mode 100644 arch/arm/mach-kirkwood/Makefile
 delete mode 100644 arch/arm/mach-kirkwood/Makefile.boot
 delete mode 100644 arch/arm/mach-kirkwood/board-dt.c
 delete mode 100644 arch/arm/mach-kirkwood/common.c
 delete mode 100644 arch/arm/mach-kirkwood/common.h
 delete mode 100644 arch/arm/mach-kirkwood/d2net_v2-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/bridge-regs.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/kirkwood.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-kirkwood/irq.c
 delete mode 100644 arch/arm/mach-kirkwood/lacie_v2-common.c
 delete mode 100644 arch/arm/mach-kirkwood/lacie_v2-common.h
 delete mode 100644 arch/arm/mach-kirkwood/mpp.c
 delete mode 100644 arch/arm/mach-kirkwood/mpp.h
 delete mode 100644 arch/arm/mach-kirkwood/netxbig_v2-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/openrd-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/pcie.c
 delete mode 100644 arch/arm/mach-kirkwood/pm.c
 delete mode 100644 arch/arm/mach-kirkwood/pm.h
 delete mode 100644 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/rd88f6281-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/t5325-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/ts219-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/ts41x-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/tsx1x-common.c
 delete mode 100644 arch/arm/mach-kirkwood/tsx1x-common.h
