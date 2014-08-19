From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 19 Aug 2014 20:27:38 +0800
Subject: [GIT PULL] ARM: imx: fixes for 3.17
Message-ID: <20140819122736.GM2114@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-3.17

for you to fetch changes up to 3bc4d037c6791c5089a04845995410aac4fdb514:

  ARM: dts: imx6sx: fix the pad setting for uart CTS_B (2014-08-19 20:06:59 +0800)

----------------------------------------------------------------
The i.MX fixes for 3.17:
 - A correction on imx6dl gpu axi clock setting
 - Fix a compilation error which comes after ARMv6K SMP build is allowed
 - Fix a typo with pinctrl_esdhc1 in vf610-twr dts
 - Correct i.MX6SX pad setting for UART in dts
 - Fix i.MX53 VPU clock settings in dts
 - Fix a suspend/resume failure seen on Cubox-i board, which is caused
   by TLB missing of IOMUXC base address during suspend
 - ARCH_HAS_OPP has been removed by commit 78c5e0bb145d (PM / OPP:
   Remove ARCH_HAS_OPP), so we need to kill it for IMX
 - A small fix on enet reset pin of edmqmx6 board

----------------------------------------------------------------
Anson Huang (1):
      ARM: imx: correct gpu2d_axi and gpu3d_axi clock setting

Arnd Bergmann (1):
      ARM: imx6: fix SMP compilation again

Bill Pringlemeir (1):
      ARM: dts: vf610-twr: Fix pinctrl_esdhc1 pin definitions.

Fugang Duan (1):
      ARM: dts: imx6sx: fix the pad setting for uart CTS_B

Lothar Wa?mann (1):
      ARM: dts: i.MX53: fix apparent bug in VPU clks

Shawn Guo (2):
      ARM: imx: fix TLB missing of IOMUXC base address during suspend
      ARM: imx: remove unnecessary ARCH_HAS_OPP select

Silvio Fricke (1):
      ARM: dts: imx6: edmqmx6: change enet reset pin

 arch/arm/boot/dts/imx53.dtsi            |  2 +-
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts |  3 ++-
 arch/arm/boot/dts/imx6sx-pinfunc.h      | 26 +++++++++++++-------------
 arch/arm/boot/dts/vf610-twr.dts         |  2 +-
 arch/arm/mach-imx/Kconfig               |  2 --
 arch/arm/mach-imx/Makefile              |  2 ++
 arch/arm/mach-imx/clk-imx6q.c           | 10 ++++++++--
 arch/arm/mach-imx/suspend-imx6.S        |  2 ++
 8 files changed, 29 insertions(+), 20 deletions(-)
