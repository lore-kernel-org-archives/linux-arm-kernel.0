From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 23 Nov 2014 16:33:54 +0800
Subject: [GIT PULL v2] ARM: imx: cleanup for 3.19
Message-ID: <20141123083353.GE11253@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
 - Rebase the change set on 3.18-rc3

The following changes since commit 0df1f2487d2f0d04703f142813d53615d62a1da4:

  Linux 3.18-rc3 (2014-11-02 15:01:51 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-cleanup-3.19

for you to fetch changes up to b50e7df946138399832af8f2b067fa6c3256a005:

  ARM: imx: Remove unneeded .map_io initialization (2014-11-22 07:39:36 +0800)

----------------------------------------------------------------
The i.MX cleanup for 3.19:
 - Clean up reset handler for DT machines, since reset has been handled
   in watchdog driver
 - Remove unneeded .map_io hook for a couple of i.MX6 machines
 - A few small i.MX6 device tree source cleanups
 - Some random iomuxc and pllv3 code cleanup

----------------------------------------------------------------
Dmitry Voytik (3):
      ARM: imx6q: drop unnecessary semicolon
      ARM: imx: simplify clk_pllv3_prepare()
      ARM: imx: refactor mxc_iomux_mode()

Fabio Estevam (4):
      ARM: dts: imx6qdl-sabresd: Use IMX6QDL_CLK_CKO define
      ARM: dts: imx6qdl-gw5x: Remove unneeded 'fsl,mode' property
      ARM: dts: imx6qdl-rex: Remove unneeded 'fsl,mode' property
      ARM: dts: imx6qdl-sabresd: Fix the microphone route

Geert Uytterhoeven (1):
      ARM: imx: Remove unneeded .map_io initialization

Jingchang Lu (1):
      ARM: imx: clean up machine mxc_arch_reset_init_dt reset init

 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi  |  1 -
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi  |  1 -
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi  |  2 --
 arch/arm/boot/dts/imx6qdl-rex.dtsi     |  1 -
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi |  8 +++-----
 arch/arm/mach-imx/clk-imx6q.c          |  2 +-
 arch/arm/mach-imx/clk-pllv3.c          |  7 +------
 arch/arm/mach-imx/common.h             |  1 -
 arch/arm/mach-imx/imx25-dt.c           |  9 ---------
 arch/arm/mach-imx/imx27-dt.c           |  3 ---
 arch/arm/mach-imx/imx31-dt.c           |  9 ---------
 arch/arm/mach-imx/imx35-dt.c           | 10 ----------
 arch/arm/mach-imx/iomux-imx31.c        |  8 ++++----
 arch/arm/mach-imx/iomux-mx3.h          |  2 +-
 arch/arm/mach-imx/mach-imx50.c         |  9 ---------
 arch/arm/mach-imx/mach-imx51.c         |  2 --
 arch/arm/mach-imx/mach-imx53.c         |  2 --
 arch/arm/mach-imx/mach-imx6q.c         |  3 ---
 arch/arm/mach-imx/mach-imx6sl.c        |  4 ----
 arch/arm/mach-imx/mach-imx6sx.c        |  4 ----
 arch/arm/mach-imx/mach-vf610.c         | 10 ----------
 arch/arm/mach-imx/system.c             | 15 ---------------
 22 files changed, 10 insertions(+), 103 deletions(-)
