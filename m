From: olof@lixom.net (Olof Johansson)
Date: Wed, 20 Jan 2016 17:14:34 -0800
Subject: [GIT PULL 1/9] ARM: SoC non-urgent fixes for v4.5
In-Reply-To: <1453338882-31300-1-git-send-email-olof@lixom.net>
References: <1453338882-31300-1-git-send-email-olof@lixom.net>
Message-ID: <1453338882-31300-2-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As usual, we queue up a few fixes that don't seem urgent enough to go in
through -rc.

- MAINTAINERS updates to add a list for brcmstb and fix a typo
- A handful of fixes for OMAP 81xx, a recently resurrected platform so these
can't be considered real regressions and thus got queued.
- A couple of other small fixes for scoop, sa1100 and davinci

----------------------------------------------------------------

The following changes since commit 99e38df892234aa985185fc776647bad6f9bd7a7:

  Merge tag 'iommu-updates-v4.5' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes-nc

for you to fetch changes up to 08ceca8ea629828e4cb922c121b5c87681c97fb7:

  Merge tag 'omap-for-v4.5/81xx-fix-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into next/fixes-non-critical

----------------------------------------------------------------

Arnd Bergmann (4):
      ARM: davinci: only select WT cache if cache is enabled
      Merge tag 'arm-soc/for-4.5/maintainers' of http://github.com/Broadcom/stblinux into next/fixes-non-critical
      Merge tag 'omap-for-v4.5/81xx-fixes-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/fixes-non-critical
      Merge tag 'omap-for-v4.5/81xx-fix-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/fixes-non-critical

Florian Fainelli (2):
      MAINTAINERS: brcmstb: Include Broadcom internal mailing-list
      MAINTAINERS: gpio-brcmstb: Remove stray '>'

Geliang Tang (1):
      ARM: davinci: fix a problematic usage of WARN()

Linus Walleij (2):
      ARM: scoop: Be sure to clamp return value
      ARM: sa1100/simpad: Be sure to clamp return value

Olof Johansson (1):
      Merge tag 'davinci-for-v4.5/fixes' of git://git.kernel.org/.../nsekhar/linux-davinci into next/fixes-non-critical

Tony Lindgren (10):
      ARM: dts: Fix dm814x entries for pllss and prcm
      clk: ti: Add few dm814x clock aliases
      ARM: OMAP2+: Add DPPLS clock manager for dm814x
      ARM: dts: Fix some mux and divider clocks to get dm814x-evm booting
      ARM: OMAP2+: Fix timer entries for dm814x
      ARM: dts: Fix dm8148 control modules ranges
      ARM: dts: Fix dm814x pinctrl address and mask
      ARM: OMAP2+: Enable GPIO for dm814x
      ARM: OMAP2+: Remove useless check for legacy booting for dm814x
      ARM: OMAP2+: Fix randconfig build warning for dm814_pllss_data


 MAINTAINERS                                 |   3 +-
 arch/arm/boot/dts/dm814x-clocks.dtsi        | 109 ++++++++++++++++-------
 arch/arm/boot/dts/dm814x.dtsi               |  33 +++++--
 arch/arm/common/scoop.c                     |   2 +-
 arch/arm/mach-davinci/Kconfig               |   3 +-
 arch/arm/mach-davinci/board-dm355-evm.c     |   4 +-
 arch/arm/mach-davinci/board-dm355-leopard.c |   4 +-
 arch/arm/mach-omap2/io.c                    |   3 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c  |  12 +--
 arch/arm/mach-omap2/prm_common.c            |   8 ++
 arch/arm/mach-sa1100/simpad.c               |   4 +-
 drivers/clk/ti/clk-814x.c                   |   4 +
 include/linux/clk/ti.h                      |   1 +
 13 files changed, 133 insertions(+), 57 deletions(-)
