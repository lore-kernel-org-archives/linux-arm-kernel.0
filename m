From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 Jan 2015 10:25:38 -0800
Subject: [GIT PULL 1/3] drop legacy booting for omap3517
Message-ID: <pull-1421777718-852183>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.20/drop-legacy-3517-v2

for you to fetch changes up to 549f95ed20168daa06901054a028e185ebb905ab:

  ARM: OMAP3: Add back Kconfig option MACH_OMAP3517EVM for ASoC (2015-01-20 08:49:08 -0800)

----------------------------------------------------------------
We have had omap3517 booting in device tree mode for quite some
time now and we have at least a minimal dts file for the 3517
based boards. Also almost all the drivers are usable in device
tree mode. And if there are any drivers not yet supported in device
tree mode, those can be enabled using pdata quirks.

This leaves omap3430 to omap3730 as the only remaining mach-omap2
platforms still booting in legacy mode also. For those were are
printing a warning during the boot to get people to update their
systems to boot in device tree mode and slowly converting them
over to device tree based booting.

----------------------------------------------------------------
Tony Lindgren (5):
      ARM: OMAP3: Remove legacy support for am3517-evm
      ARM: OMAP3: Remove legacy support for am3517crane
      ARM: OMAP3: Remove cm-t3517 legacy support
      ARM: OMAP3: Remove legacy support for am35xx-emac
      ARM: OMAP3: Add back Kconfig option MACH_OMAP3517EVM for ASoC

 arch/arm/mach-omap2/Kconfig                |  12 -
 arch/arm/mach-omap2/Makefile               |   8 -
 arch/arm/mach-omap2/am35xx-emac.c          | 114 ---------
 arch/arm/mach-omap2/am35xx-emac.h          |  15 --
 arch/arm/mach-omap2/am35xx.h               |  46 ----
 arch/arm/mach-omap2/board-am3517crane.c    | 150 ------------
 arch/arm/mach-omap2/board-am3517evm.c      | 373 -----------------------------
 arch/arm/mach-omap2/board-cm-t3517.c       | 335 --------------------------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  33 +--
 arch/arm/mach-omap2/pdata-quirks.c         |   1 -
 10 files changed, 2 insertions(+), 1085 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/am35xx-emac.c
 delete mode 100644 arch/arm/mach-omap2/am35xx-emac.h
 delete mode 100644 arch/arm/mach-omap2/am35xx.h
 delete mode 100644 arch/arm/mach-omap2/board-am3517crane.c
 delete mode 100644 arch/arm/mach-omap2/board-am3517evm.c
 delete mode 100644 arch/arm/mach-omap2/board-cm-t3517.c
