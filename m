From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 08 Jun 2015 11:39:14 -0700
Subject: [GIT PULL] ARM: SoC fixes for v4.1-rc8
Message-ID: <7hr3pmt57x.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c65b99f046843d2455aa231747b5a07a999a9f3d:

  Linux 4.1-rc6 (2015-05-31 19:01:07 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to 0a68c6bc7ce9d4855f3130f9eff8ff774b597531:

  Merge tag 'omap-for-v4.1/fixes-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes (2015-06-08 10:32:55 -0700)

----------------------------------------------------------------
ARM: SoC fixes for v4.1-rc

About 10 days worth of small bug fixes, and the (hopefully) final
round fixes for from arm-soc land for the -rc cycle.  Nothing special
to note, but here's a brief summary of fixes by SoC type:

- OMAP: small set of misc. DT fixes; boot fix for THUMB2 kernel
- mediatek: PMIC fixes; DT fix for model name
- exynos: wakeup interupt fixes for 3250
- mvebu: revert mbus patch which broke DMA masters

----------------------------------------------------------------
Arnd Bergmann (4):
      Merge tag 'v4.1-next-soc' of https://github.com/mbgg/linux-mediatek into fixes
      Merge tag 'mvebu-fixes-4.1-3' of git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'samsung-fixes-4.1-4' of https://github.com/krzk/linux into fixes
      Merge tag 'v4.1-next-arm64-fixes' of https://github.com/mbgg/linux-mediatek into fixes

Imre Kaloz (1):
      ARM: mvebu: armada-xp-linksys-mamba: Disable internal RTC

Kevin Hilman (1):
      Merge tag 'omap-for-v4.1/fixes-rc6' of git://git.kernel.org/.../tmlind/linux-omap into fixes

Marc Zyngier (1):
      ARM: exynos: Fix wake-up interrupts for Exynos3250

Matthias Brugger (1):
      soc: mediatek: Add compile dependency to pmic-wrapper

Matthijs van Duin (1):
      ARM: dts: am335x-boneblack: disable RTC-only sleep to avoid hardware damage

Nicolas Schichan (1):
      bus: mvebu-mbus: do not set WIN_CTRL_SYNCBARRIER on non io-coherent platforms.

Pavel Machek (1):
      ARM: dts: Fix n900 dts file to work around 4.1 touchscreen regression on n900

Sascha Hauer (2):
      soc: mediatek: PMIC wrap: Fix clock rate handling
      soc: mediatek: PMIC wrap: Fix register state machine handling

Tero Kristo (1):
      ARM: dts: AM35xx: fix system control module clocks

Thomas Petazzoni (1):
      Revert "bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus bridge window"

Tony Lindgren (2):
      ARM: OMAP3: Fix booting with thumb2 kernel
      ARM: dts: Fix dm816x to use right compatible flag for MUSB

Yingjoe Chen (1):
      arm64: dts: mt8173-evb: fix model name

 Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt |   4 +--
 arch/arm/boot/dts/am335x-bone-common.dtsi                       |  19 ++++++++++
 arch/arm/boot/dts/am35xx-clocks.dtsi                            |  14 ++++----
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts                   |   5 +++
 arch/arm/boot/dts/dm816x.dtsi                                   |   4 +--
 arch/arm/boot/dts/omap3-n900.dts                                |   4 +--
 arch/arm/mach-exynos/suspend.c                                  |   4 +--
 arch/arm/mach-omap2/sleep34xx.S                                 |  22 ++----------
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts                     |   3 +-
 drivers/bus/mvebu-mbus.c                                        | 109 ++++++++++------------------------------------------------
 drivers/soc/mediatek/Kconfig                                    |   1 +
 drivers/soc/mediatek/mtk-pmic-wrap.c                            |  54 +++++------------------------
 12 files changed, 72 insertions(+), 171 deletions(-)
