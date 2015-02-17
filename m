From: olof@lixom.net (Olof Johansson)
Date: Tue, 17 Feb 2015 00:33:22 -0800
Subject: [GIT PULL 1/7] ARM: SoC non-critical fixes
In-Reply-To: <1424162008-23768-1-git-send-email-olof@lixom.net>
References: <1424162008-23768-1-git-send-email-olof@lixom.net>
Message-ID: <1424162008-23768-2-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's a small collection of fixes accrued during the last release that weren't
considered severe enough to merge during the -rc series.

A few of these are around resurrecting TI81xx support that's been broken for
quite a while, the rest are smaller fixes -- most for PXA but a few across
the board.

There are also some updates to MAINTAINERS here, in particular for Broadcom
platforms.


Conflicts:  None

----------------------------------------------------------------

The following changes since commit eaa27f34e91a14cdceed26ed6c6793ec1d186115:

  linux 3.19-rc4 (2015-01-11 12:44:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-non-critical-for-linus

for you to fetch changes up to 11fe05de8b73816b7d12309ae55ca61c531c4e06:

  Merge tag 'arm-soc/for-3.20/maintainer' of http://github.com/broadcom/stblinux into next/fixes-non-critical

----------------------------------------------------------------

Dmitry Eremin-Solenikov (3):
      ARM: pxa: add regulator_has_full_constraints to corgi board file
      ARM: pxa: add regulator_has_full_constraints to poodle board file
      ARM: pxa: add regulator_has_full_constraints to spitz board file

Florian Fainelli (5):
      MAINTAINERS: move BCM63xx ARM-based SoCs git tree
      MAINTAINERS: update Broadcom Cygnus SoC git tree
      MAINTAINERS: add a git entry for BCM7xxx ARM-based SoCs
      MAINTAINERS: add a git entry for BMIPS-based BCM7xxx SoCs
      MAINTAINERS: fix git repositories for Broadcom SoCs

Keerthy (1):
      ARM: OMAP: DRA7: hwmod: Make gpmc software supervised as the smart idle is broken

Lokesh Vutla (2):
      ARM: OMAP2+: hwmod: print error if wait_target_ready() failed
      ARM: DRA7: hwmod: Fix boot crash with DEBUG_LL enabled on UART3

Martin Vajnar (1):
      hx4700: regulator: declare full constraints

Olof Johansson (5):
      Merge tag 'arm-soc/for-3.20/maintainer' of http://github.com/broadcom/stblinux into next/fixes-non-critical
      Merge tag 'omap-for-v3.20/fixes-not-urgent-pt1' of git://git.kernel.org/.../tmlind/linux-omap into next/fixes-non-critical
      Merge tag 'pxa-for-3.20' of https://github.com/rjarzmik/linux into next/fixes-non-critical
      Merge tag 'omap-for-v3.20/fixes-not-urgent-pt2' of git://git.kernel.org/.../tmlind/linux-omap into next/fixes-non-critical
      Merge tag 'arm-soc/for-3.20/maintainer' of http://github.com/broadcom/stblinux into next/fixes-non-critical

Paul Walmsley (1):
      MAINTAINERS: add maintainer for OMAP hwmod data

Robert Jarzmik (3):
      arm: pxa: fix pxa27x device-tree support kconfig
      ARM: pxa: arbitrarily set first interrupt number
      ARM: pxa: fix broken isa interrupts for zeus and viper

Tomi Valkeinen (1):
      ARM: AM43xx: hwmod: set DSS submodule parent hwmods

Tony Lindgren (7):
      ARM: OMAP2+: Fix error handling for omap2_clk_enable_init_clocks
      ARM: OMAP2+: Fix ti81xx devtype
      ARM: OMAP2+: Fix ti81xx class type
      ARM: OMAP2+: Fix dm814 and dm816 for clocks and timer init
      ARM: OMAP2+: Fix reboot for 81xx
      ARM: OMAP2+: Disable omap3 PM init for ti81xx
      Merge tag 'for-v3.20/omap-hwmod-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.20/fixes-not-urgent


 MAINTAINERS                                 | 12 +++++++--
 arch/arm/mach-omap2/Makefile                |  1 +
 arch/arm/mach-omap2/clock.c                 |  3 +++
 arch/arm/mach-omap2/common.h                | 11 +++++++-
 arch/arm/mach-omap2/control.h               |  4 +++
 arch/arm/mach-omap2/id.c                    |  2 ++
 arch/arm/mach-omap2/io.c                    | 26 ++++++++++++++----
 arch/arm/mach-omap2/omap_hwmod.c            |  4 +--
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c  |  2 ++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c   |  5 ++--
 arch/arm/mach-omap2/powerdomains3xxx_data.c |  2 +-
 arch/arm/mach-omap2/prm_common.c            |  4 +++
 arch/arm/mach-omap2/soc.h                   |  4 +--
 arch/arm/mach-omap2/ti81xx-restart.c        | 34 ++++++++++++++++++++++++
 arch/arm/mach-omap2/timer.c                 |  2 ++
 arch/arm/mach-pxa/Kconfig                   |  6 -----
 arch/arm/mach-pxa/corgi.c                   |  3 +++
 arch/arm/mach-pxa/hx4700.c                  |  2 ++
 arch/arm/mach-pxa/include/mach/irqs.h       | 10 +++----
 arch/arm/mach-pxa/poodle.c                  |  2 ++
 arch/arm/mach-pxa/spitz.c                   |  2 ++
 21 files changed, 113 insertions(+), 28 deletions(-)
 create mode 100644 arch/arm/mach-omap2/ti81xx-restart.c
