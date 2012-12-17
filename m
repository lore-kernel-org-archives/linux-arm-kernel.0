From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 17 Dec 2012 11:37:44 +0100
Subject: [GIT PULL] i.MX fixes for -rc
Message-ID: <20121217103744.GL26326@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following i.MX fixes for -rc.

Thanks
 Sascha


The following changes since commit a4f1de176614f634c367e5994a7bcc428c940df0:

  mm: fix kernel BUG at huge_memory.c:1474! (2012-12-16 19:02:38 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-fixes-rc

for you to fetch changes up to 027c0a6af42efa4f2f6034421349bd26a3ca4923:

  ARM: imx: Move platform-mx2-emma to arch/arm/mach-imx/devices (2012-12-17 10:58:52 +0100)

----------------------------------------------------------------
ARM i.MX fixes for v3.8-rc

This fixes a compile failure on imx_v4_v5_defconfig and a regression
introduced with enabling the MIPI clocks on i.MX51. Also one rather
cosmetic fix for the i.MX27 dts file.

----------------------------------------------------------------
Fabio Estevam (2):
      ARM: dts: mx27: Fix the AIPI bus for FEC
      ARM: imx: Move platform-mx2-emma to arch/arm/mach-imx/devices

Sascha Hauer (1):
      ARM i.MX51 clock: Fix regression since enabling MIPI/HSP clocks

 arch/arm/boot/dts/imx27-3ds.dts                        |    8 ++++----
 arch/arm/boot/dts/imx27-phytec-phycore.dts             |   13 +++++++------
 arch/arm/boot/dts/imx27.dtsi                           |   11 ++++++++++-
 arch/arm/mach-imx/clk-imx51-imx53.c                    |   16 ++++++++++++++++
 .../{plat-mxc => mach-imx}/devices/platform-mx2-emma.c |    4 ++--
 5 files changed, 39 insertions(+), 13 deletions(-)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-mx2-emma.c (94%)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
