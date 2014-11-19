From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 19 Nov 2014 15:01:53 +0800
Subject: [GIT PULL] ARM: imx: cleanup for 3.19
Message-ID: <20141119070152.GE27759@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit fc14f9c1272f62c3e8d01300f52467c0d9af50f9:

  Linux 3.18-rc5 (2014-11-16 16:36:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-cleanup-3.19

for you to fetch changes up to 7d1fdf147f445c75573e72e82d38de1241693d1f:

  ARM: imx: Remove unneeded .map_io initialization (2014-11-19 11:24:26 +0800)

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
