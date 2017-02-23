From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Feb 2017 00:05:07 +0100
Subject: [GIT PULL 1/7] ARM: SoC non-urgent fixes for merge window
In-Reply-To: <8729461.VkrRdW7LzJ@wuerfel>
References: <8729461.VkrRdW7LzJ@wuerfel>
Message-ID: <9013724.FUQHNQsY9n@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:

  Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes-nc

for you to fetch changes up to 92f3e6ebf6e43fdd5e2f044fc26d973f341b7ef0:

  firmware: arm_scpi: Add hardware dependencies (2017-01-30 21:09:43 -0800)

----------------------------------------------------------------
ARM: SoC non-urgent fixes for merge window

We sometimes collect non-critical fixes that come in during the later part
of the merge window in a branch for the next release instead, and this is
that contents for v4.11.

Most of these are OMAP fixes, dealing with OMAP36/37 detection, quirks
and setup. There's also some fixes for Davinci and a Kconfig fix for SCPI
to only enable on ARM{,64}.

----------------------------------------------------------------
Adam Ford (1):
      ARM: OMAP3: Fix SoC detection of OMAP36/37 Family

Bartosz Golaszewski (3):
      ARM: davinci: da850: coding style fix
      ARM: davinci: da850: fix da850_set_pll0rate()
      bus: da850-mstpri: fix my e-mail address

Jean Delvare (1):
      firmware: arm_scpi: Add hardware dependencies

Olof Johansson (2):
      Merge tag 'davinci-for-v4.11/fixes-non-critical' of git://git.kernel.org/.../nsekhar/linux-davinci into next/fixes-non-critical
      Merge tag 'omap-for-v4.11/fixes-not-urgent-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/fixes-non-critical

Tony Lindgren (4):
      ARM: dts: Fix omap3 off mode pull defines
      ARM: OMAP2+: Fix init for multiple quirks for the same SoC
      ARM: dts: Fix am335x and dm814x scm syscon to probe children
      ARM: dts: Fix compatible for ti81xx uarts for 8250

Vignesh R (1):
      ARM: OMAP5: Add HWMOD_SWSUP_SIDLE_ACT flag for UART

 arch/arm/boot/dts/am33xx.dtsi              |  3 ++-
 arch/arm/boot/dts/dm814x.dtsi              |  9 +++++----
 arch/arm/boot/dts/dm816x.dtsi              |  6 +++---
 arch/arm/mach-davinci/da850.c              | 24 +++++++++++++++++++-----
 arch/arm/mach-omap2/id.c                   | 10 +++++++++-
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c |  8 ++++++--
 arch/arm/mach-omap2/pdata-quirks.c         |  1 -
 drivers/bus/da8xx-mstpri.c                 |  2 +-
 drivers/cpufreq/davinci-cpufreq.c          |  2 +-
 drivers/firmware/Kconfig                   |  1 +
 include/dt-bindings/pinctrl/omap.h         |  4 ++--
 11 files changed, 49 insertions(+), 21 deletions(-)
