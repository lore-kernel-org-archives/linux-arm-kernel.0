From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Dec 2017 07:58:25 -0800
Subject: [GIT PULL 1/3] soc changes for omaps for v4.16 merge window
Message-ID: <pull-1513266986-900907@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.16/soc-signed

for you to fetch changes up to fdf3632938a646c13f7407f2f8c33ff81eed9c76:

  Merge branch '4.15-rc1-clkctrl-mach-omap2' of https://github.com/t-kristo/linux-pm into omap-for-v4.16/soc (2017-12-11 07:46:40 -0800)

----------------------------------------------------------------
SoC changes for omaps for v4.16 merge window

For most part this is a series from Tero Kristo to prepare things
for using clkctrl clocks with DTS data. The other changes are to
make few data structures const.

----------------------------------------------------------------
Bhumika Goyal (2):
      ARM: OMAP2+: CM: make some pointers and function arguments as const
      ARM: OMAP2+: CM: make cm_ll_data structures as const

Tero Kristo (7):
      ARM: OMAP2+: CM: add support for getting phys address for a clkctrl register
      ARM: OMAP4: CMINST: add support for translating clkctrl addresses
      ARM: OMAP2+: hwmod: fix clkctrl address translation logic
      ARM: OMAP2+: clockdomain: remove the obsolete clkdm_xlate_address API
      ARM: AM33xx: CM: add support for getting physical address for a register
      ARM: OMAP2+: hwmod: calculate physical register address on am33xx
      ARM: DM816x: hwmod_data: fix clockdomain name for sata hwmod

Tony Lindgren (1):
      Merge branch '4.15-rc1-clkctrl-mach-omap2' of https://github.com/t-kristo/linux-pm into omap-for-v4.16/soc

 arch/arm/mach-omap2/clockdomain.c          |  8 ----
 arch/arm/mach-omap2/clockdomain.h          |  2 -
 arch/arm/mach-omap2/cm.h                   |  7 ++-
 arch/arm/mach-omap2/cm2xxx.c               |  2 +-
 arch/arm/mach-omap2/cm33xx.c               |  8 +++-
 arch/arm/mach-omap2/cm3xxx.c               |  2 +-
 arch/arm/mach-omap2/cm_common.c            | 16 +++++--
 arch/arm/mach-omap2/cminst44xx.c           | 12 ++---
 arch/arm/mach-omap2/omap_hwmod.c           | 73 +++++++++++++++---------------
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c |  2 +-
 10 files changed, 68 insertions(+), 64 deletions(-)
