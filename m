From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Mar 2015 14:12:52 -0700
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20150329211252.GA15216@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,


The following changes since commit 06e5801b8cb3fc057d88cb4dc03c0b64b2744cda:

  Linux 4.0-rc4 (2015-03-15 17:38:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-for-linus

for you to fetch changes up to 4550bdb0bd8fd603412eab53bd331be5ef8e47a0:

  Merge tag 'sunxi-fixes-for-4.0' of https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux into fixes (2015-03-29 14:01:02 -0700)

----------------------------------------------------------------
ARM: SoC fixes

The latest and greatest fixes for ARM platform code. Worth pointing out are:

- Lines-wise, largest is a PXA fix for dealing with interrupts on DT that was
  quite broken. It's still newish code so while we could have held this off,
  it seemed appropriate to include now
- Some GPIO fixes for OMAP platforms added a few lines. This was also fixes for
  code recently added (this release).
- Small OMAP timer fix to behave better with partially upstreamed platforms,
  which is quite welcome.
- Allwinner fixes about operating point control, reducing overclocking in some
  cases for better stability.

+ a handful of other smaller fixes across the map.

----------------------------------------------------------------
Alexandru M Stan (1):
      ARM: dts: rockchip: disable gmac by default in rk3288.dtsi

Arnd Bergmann (1):
      Merge tag 'v4.0-rockchip-armfixes1' of git://git.kernel.org/.../mmind/linux-rockchip into fixes

Chen-Yu Tsai (3):
      ARM: sunxi: Have ARCH_SUNXI select RESET_CONTROLLER for clock driver usage
      ARM: dts: sun4i: a10-lime: Override and remove 1008MHz OPP setting
      ARM: dts: sunxi: Remove overclocked/overvoltaged OPP

Dave Martin (1):
      arm64: juno: Fix misleading name of UART reference clock

Heiko Stuebner (1):
      MAINTAINERS: add rockchip regexp to the ARM/Rockchip entry

Kishon Vijay Abraham I (1):
      ARM: dts: dra7: remove ti,hwmod property from pcie phy

Mark James (1):
      ARM: socfpga: dts: fix spi1 interrupt

Masanari Iida (1):
      ARM: pxa: Fix typo in zeus.c

Olof Johansson (4):
      Merge tag 'fixes-for-v4.0-rc5' of https://github.com/rjarzmik/linux into fixes
      Merge tag 'socfpga_fix_for_v4.0_2' of git://git.rocketboards.org/linux-socfpga-next into fixes
      Merge tag 'fixes-v4.0-rc4' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'sunxi-fixes-for-4.0' of https://git.kernel.org/.../mripard/linux into fixes

Pali Roh?r (1):
      ARM: dts: omap3: Add missing dmas for crypto

Robert Jarzmik (1):
      ARM: pxa: fix pxa interrupts handling in DT

Suman Anna (3):
      ARM: OMAP2+: Fix socbus family info for AM33xx devices
      ARM: OMAP: dmtimer: check for pm_runtime_get_sync() failure
      ARM: OMAP: dmtimer: disable pm runtime on remove

Tony Lindgren (1):
      ARM: dts: Fix gpio interrupts for dm816x

 MAINTAINERS                                    |   1 +
 arch/arm/Kconfig                               |   1 +
 arch/arm/boot/dts/dm8168-evm.dts               |  19 +++++
 arch/arm/boot/dts/dm816x.dtsi                  |  18 +++-
 arch/arm/boot/dts/dra7.dtsi                    |   2 -
 arch/arm/boot/dts/omap3.dtsi                   |   4 +
 arch/arm/boot/dts/rk3288.dtsi                  |   1 +
 arch/arm/boot/dts/socfpga.dtsi                 |   2 +-
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts |  16 ++++
 arch/arm/boot/dts/sun4i-a10.dtsi               |   3 +-
 arch/arm/boot/dts/sun5i-a13.dtsi               |   3 +-
 arch/arm/boot/dts/sun7i-a20.dtsi               |   3 +-
 arch/arm/mach-omap2/id.c                       |   2 +
 arch/arm/mach-pxa/irq.c                        | 111 +++++++++++--------------
 arch/arm/mach-pxa/zeus.c                       |   2 +-
 arch/arm/mach-sunxi/Kconfig                    |   8 +-
 arch/arm/plat-omap/dmtimer.c                   |  15 +++-
 arch/arm64/boot/dts/arm/juno-clocks.dtsi       |   2 +-
 18 files changed, 128 insertions(+), 85 deletions(-)
