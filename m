From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 05 May 2016 21:56:33 +0200
Subject: [GIT PULL] ARM SoC fixes for 4.6
Message-ID: <4719866.mossMk4AmU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[resent to fix the subject line]

The following changes since commit 02da2d72174c61988eb4456b53f405e3ebdebce4:

  Linux 4.6-rc5 (2016-04-24 16:17:05 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to ed19ca7fa8bd44936aa3d5284bf38f5d96a28b35:

  Merge tag 'sunxi-fixes-for-4.6' of https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux into fixes (2016-04-29 12:04:02 -0700)

----------------------------------------------------------------
Here are a couple last-minute fixes for ARM SoCs. Most of them
are for the OMAP platforms, quoting Tony Lindgren:

    Fixes for omaps for v4.6-rc cycle. All dts fixes, mostly
    affecting voltages and pinctrl for various device drivers:

    - Regulator minimum voltage fixes for omap5
    - ISP syscon register offset fix for omap3
    - Fix regulator initial modes for n900
    - Fix omap5 pinctrl wkup instance size

The rest are all for different platforms:

- Allwinner:
   Remove incorrect constraints from a dcdc1 regulator

- Alltera SoCFPGA:
  Fix compilation in thumb2 mode

- Samsung exynos:
  Fix a potential oops in the pm-domain error handling

- Davinci:
  Avoid a link error if NVMEM is disabled

- Renesas:
  Do not mark an external uart clock as disabled, to allow
  probing the uarts

----------------------------------------------------------------

Arnd Bergmann (4):
      Merge tag 'samsung-fixes-4.6' of git://git.kernel.org/.../krzk/linux into fixes
      Merge tag 'omap-for-v4.6/fixes-rc5-signed' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'renesas-fixes2-for-v4.6' of git://git.kernel.org/.../horms/renesas into fixes
      ARM: davinci: only use NVMEM when available

Geert Uytterhoeven (1):
      arm64: dts: r8a7795: Don't disable referenced optional scif clock

H. Nikolaus Schaller (1):
      ARM: dts: omap5: fix range of permitted wakeup pinmux registers

Hans de Goede (1):
      ARM: dts: sun8i-q8-common: Do not set constraints on dc1sw regulator

Ivaylo Dimitrov (2):
      ARM: dts: omap3: Fix ISP syscon register offset
      ARM: dts: omap3-n900: Specify peripherals LDO regulators initial mode

Kevin Hilman (1):
      Merge tag 'sunxi-fixes-for-4.6' of https://git.kernel.org/.../mripard/linux into fixes

Krzysztof Kozlowski (1):
      ARM: EXYNOS: Properly skip unitialized parent clock in power domain on

Sascha Hauer (1):
      ARM: SoCFPGA: Fix secondary CPU startup in thumb2 kernel

Tomi Valkeinen (2):
      ARM: dts: omap5-board-common: fix ldo1_reg and ldo4_reg ranges
      ARM: dts: omap5-cm-t54: fix ldo1_reg and ldo4_reg ranges

 arch/arm/boot/dts/omap3-n900.dts           |  9 +++++++++
 arch/arm/boot/dts/omap34xx.dtsi            |  2 +-
 arch/arm/boot/dts/omap5-board-common.dtsi  |  4 ++--
 arch/arm/boot/dts/omap5-cm-t54.dts         |  4 ++--
 arch/arm/boot/dts/omap5.dtsi               |  2 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts      |  1 +
 arch/arm/boot/dts/r8a7791-porter.dts       | 14 +-------------
 arch/arm/boot/dts/r8a7791.dtsi             |  5 +----
 arch/arm/boot/dts/sun8i-q8-common.dtsi     |  2 --
 arch/arm/mach-davinci/board-mityomapl138.c |  5 +++++
 arch/arm/mach-davinci/common.c             |  5 +++++
 arch/arm/mach-exynos/pm_domains.c          |  2 +-
 arch/arm/mach-shmobile/timer.c             | 28 +++++++++++-----------------
 arch/arm/mach-socfpga/headsmp.S            |  1 +
 arch/arm64/boot/dts/renesas/r8a7795.dtsi   |  1 -
 15 files changed, 41 insertions(+), 44 deletions(-)
