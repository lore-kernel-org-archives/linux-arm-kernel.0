From: olof@lixom.net (Olof Johansson)
Date: Fri, 30 Dec 2011 09:43:52 -0800
Subject: [GIT PULL] ARM SoC fixes for 3.2-rc
Message-ID: <CAOesGMg4Mn6_7xCRFoDSXkuCyUiCunidx1mtOQ=sa10409Ai5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here is what should be the last set of fixes for arm-soc for 3.2-rc.

Apologies for sending this out as late as it is -- between holidays
and various other things the sending of the pull request fell between
chairs.

I also noticed now when doing the request that some of the patch
descriptions aren't prefixed properly. I'll keep a closer eye on that
in the future.


-Olof


The following changes since commit 5f0a6e2d503896062f641639dacfe5055c2f593b:

  Linux 3.2-rc7 (2011-12-23 21:51:06 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git fixes

for you to fetch changes up to 00ca4e4c8f72f2a67466a41b12714ed8c9e10f64:

  Merge branch 'fixes-hwmod-regression' of
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into
fixes (2011-12-20 09:56:00 -0800)

----------------------------------------------------------------

Eric B?nard (7):
      cpuimx25sd: fix Kconfig
      imx_v4_v5_defconfig: update default configuration
      dma: MX3_IPU fix depends
      clock-imx35: fix reboot in internal boot mode
      cpuimx35sd: fix Kconfig
      cpuimx35: fix touchscreen support
      enable uncompress log on cpuimx35sd

Felipe Contreras (1):
      ARM: OMAP: hwmod data: fix iva and mailbox hwmods for OMAP 3

Holger Brunck (1):
      ARM: plat-orion: make gpiochip label unique

Jason Chen (1):
      ARM:imx:fix pwm period value

Olof Johansson (1):
      Merge branch 'fixes-hwmod-regression' of
git://git.kernel.org/.../tmlind/linux-omap into fixes

Richard Zhao (1):
      arm/imx: fix cpufreq section mismatch

 arch/arm/configs/imx_v4_v5_defconfig        |   12 +++++++-----
 arch/arm/mach-imx/Kconfig                   |    8 ++++----
 arch/arm/mach-imx/Makefile                  |    4 ++--
 arch/arm/mach-imx/clock-imx35.c             |   20 ++++++++++----------
 arch/arm/mach-imx/mach-cpuimx35.c           |    8 +++++++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c  |    4 ----
 arch/arm/plat-mxc/cpufreq.c                 |    2 +-
 arch/arm/plat-mxc/include/mach/uncompress.h |    1 +
 arch/arm/plat-mxc/pwm.c                     |    9 +++++++++
 arch/arm/plat-orion/gpio.c                  |    6 +++++-
 drivers/dma/Kconfig                         |    4 ++--
 11 files changed, 48 insertions(+), 30 deletions(-)
