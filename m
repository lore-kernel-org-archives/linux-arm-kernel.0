From: tony@atomide.com (Tony Lindgren)
Date: Wed, 24 Oct 2012 11:50:00 -0700
Subject: [GIT PULL] omap fixes for v3.7-rc2
Message-ID: <20121024184959.GI5605@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:

  Linux 3.7-rc2 (2012-10-20 12:11:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.7-rc2/fixes-signed

for you to fetch changes up to 12ac7f9e117facfe128d6e569953fa73d2d676b3:

  ARM: AM33XX: Fix configuration of dmtimer parent clock by dmtimer driverDate:Wed, 17 Oct 2012 13:55:55 -0500 (2012-10-23 18:58:21 -0700)

----------------------------------------------------------------
Timer fix for am33xx, runtime PM fix for UART, audio McBSP fixes,
mux and pinctrl fixes, and Beagle OPP fix.

----------------------------------------------------------------
Kevin Hilman (2):
      ARM: OMAP2: UART: fix console UART mismatched runtime PM status
      ARM: OMAP3: Beagle: fix OPP customization and initcall ordering

Paul Walmsley (1):
      ARM: OMAP3: PM: apply part of the erratum i582 workaround

Peter Ujfalusi (1):
      ARM/dts: omap3: Fix mcbsp2/3 hwmods to be able to probe the drivers for audio

Tony Lindgren (3):
      ARM: OMAP2+: Fix location of select PINCTRL
      ARM: OMAP3: Fix 3430 legacy mux names for ssi1 signals.
      Merge tag 'for_3.7-rc3-fixes-pm' of git://git.kernel.org/.../khilman/linux-omap-pm into omap-for-v3.7-rc2/fixes

Vaibhav Hiremath (1):
      ARM: AM33XX: Fix configuration of dmtimer parent clock by dmtimer driverDate:Wed, 17 Oct 2012 13:55:55 -0500

 arch/arm/boot/dts/omap3.dtsi            |    4 ++--
 arch/arm/mach-omap2/Kconfig             |    1 -
 arch/arm/mach-omap2/board-omap3beagle.c |   22 +++++++++++++---------
 arch/arm/mach-omap2/clock33xx_data.c    |    2 ++
 arch/arm/mach-omap2/mux34xx.c           |    8 ++++----
 arch/arm/mach-omap2/pm.h                |    1 +
 arch/arm/mach-omap2/pm34xx.c            |   30 ++++++++++++++++++++++++++++--
 arch/arm/mach-omap2/serial.c            |    5 +++++
 arch/arm/plat-omap/Kconfig              |    1 +
 9 files changed, 56 insertions(+), 18 deletions(-)
