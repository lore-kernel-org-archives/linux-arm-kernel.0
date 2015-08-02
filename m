From: olof@lixom.net (Olof Johansson)
Date: Sun, 2 Aug 2015 09:29:38 +0200
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20150802072938.GA27455@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here's this week's pull request for arm-soc. Please merge.


Thanks!

-Olof


The following changes since commit 3eae03daa538303e0d28f56412c6c51f6452e493:

  Merge tag 'pxa-fixes-v4.2-rc2' of https://github.com/rjarzmik/linux into fixesD (2015-07-18 21:06:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-for-linus

for you to fetch changes up to c1bfa985ded82cacdfc6403e78f329c44e35534a:

  ARM: dts: keystone: fix dt bindings to use post div register for mainpll (2015-07-31 22:30:11 +0200)

----------------------------------------------------------------
ARM: SoC fixes

Things are calming down nicely here w.r.t. fixes. This batch includes two
week's worth since I missed to send before -rc4.

Nothing particularly scary to point out, smaller fixes here and
there. Shortlog describes it pretty well.

----------------------------------------------------------------
Beata Michalska (1):
      ARM: dts: Update video-phy node with syscon phandle for exynos3250

Denis Carikli (1):
      ARM: dts: i.MX35: Fix can support.

Linus Walleij (1):
      ARM: nomadik: disable UART0 on Nomadik boards

Murali Karicheri (1):
      ARM: dts: keystone: fix dt bindings to use post div register for mainpll

Olof Johansson (3):
      Merge tag 'samsung-fixes-1' of git://git.kernel.org/.../kgene/linux-samsung into fixes
      Merge tag 'for-v4.2-rc/omap-fixes-a' of git://git.kernel.org/.../pjw/omap-pending into fixes
      Merge tag 'imx-fixes-4.2-2' of git://git.kernel.org/.../shawnguo/linux into fixes

Roger Quadros (2):
      ARM: DRA7: hwmod: fix gpmc hwmod
      ARM: OMAP2+: hwmod: Fix _wait_target_ready() for hwmods without sysc

Thomas Abraham (1):
      ARM: dts: add CPU OPP and regulator supply property for exynos4210

 arch/arm/boot/dts/exynos3250.dtsi               |  2 +-
 arch/arm/boot/dts/exynos4210-origen.dts         |  4 ++++
 arch/arm/boot/dts/exynos4210-trats.dts          |  4 ++++
 arch/arm/boot/dts/exynos4210-universal_c210.dts |  4 ++++
 arch/arm/boot/dts/exynos4210.dtsi               | 12 ++++++++++++
 arch/arm/boot/dts/imx35.dtsi                    |  8 ++++----
 arch/arm/boot/dts/k2e-clocks.dtsi               |  5 ++---
 arch/arm/boot/dts/k2hk-clocks.dtsi              |  5 ++---
 arch/arm/boot/dts/k2l-clocks.dtsi               |  5 ++---
 arch/arm/boot/dts/ste-nomadik-nhk15.dts         |  1 +
 arch/arm/boot/dts/ste-nomadik-s8815.dts         |  4 ++++
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi      |  1 +
 arch/arm/mach-omap2/omap_hwmod.c                | 24 ++++++++++++++++--------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c       |  5 ++---
 14 files changed, 59 insertions(+), 25 deletions(-)
