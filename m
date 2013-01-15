From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 15 Jan 2013 21:43:38 +0800
Subject: [GIT PULL] imx fixes for 3.8, take 2
Message-ID: <20130115134337.GA6574@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit e37f0d5b32c2a66677d0f2a21431a87e7e9ce22d:

  ARM: mx5: Fix MX53 flexcan2 clock (2013-01-08 08:53:07 +0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-fixes-3.8-2

for you to fetch changes up to 83ae20981ae924c37d02a42c829155fc3851260c:

  ARM: imx: correct low-power mode setting (2013-01-14 22:19:48 +0800)

----------------------------------------------------------------
It's the second batch of fixes for 3.8, which includes one fixing for
!CONFIG_SMP build, two patches fixing broken imxfb driver caused by
multiplatform conversion, and a couple of pm/hotplug fixes.

----------------------------------------------------------------
Gwenhael Goavec-Merou (2):
      ARM: imx: platform-imx-fb: modifies platform device name
      video: imxfb: fix imxfb_info configuration order

Shawn Guo (3):
      ARM: imx: fix build error with !CONFIG_SMP
      ARM: imx: disable cpu in .cpu_kill hook
      ARM: imx: correct low-power mode setting

 arch/arm/mach-imx/Kconfig                   |    1 +
 arch/arm/mach-imx/clk-imx6q.c               |    3 +++
 arch/arm/mach-imx/common.h                  |    1 +
 arch/arm/mach-imx/devices/platform-imx-fb.c |    2 +-
 arch/arm/mach-imx/hotplug.c                 |   10 ++++++----
 arch/arm/mach-imx/platsmp.c                 |    1 +
 arch/arm/mach-imx/pm-imx6q.c                |    1 +
 drivers/video/imxfb.c                       |    3 ++-
 8 files changed, 16 insertions(+), 6 deletions(-)
