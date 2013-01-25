From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 25 Jan 2013 11:15:10 +0100
Subject: [GIT PULL] i.MX SoC updates for v3.9
Message-ID: <20130125101510.GK1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following (mostly clock relates) updates for v3.9.

Sascha

The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:

  Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-soc

for you to fetch changes up to 3ea8098572280d16163a429e0f8dfd90492a5934:

  ARM: clk-imx35: Fix build warnings with W=1 (2013-01-25 11:12:38 +0100)

----------------------------------------------------------------
ARM i.MX SoC updates for next

Mostly clock related updates, most notably the conversion of
i.MX31 to a DT based lookup.

----------------------------------------------------------------
Fabio Estevam (4):
      ARM: Let CONFIG_MACH_IMX31_DT be built by default
      ARM: clk-imx31: Add dummy clock
      ARM: mx31: Replace clk_register_clkdev with clock DT lookup
      ARM: clk-imx35: Fix build warnings with W=1

Gwenhael Goavec-Merou (1):
      ARM: imx27: add a clock gate to activate SPLL clock

 .../devicetree/bindings/clock/imx31-clock.txt      |   91 ++++++++++++++++++++
 arch/arm/boot/dts/imx31.dtsi                       |   17 ++++
 arch/arm/configs/imx_v6_v7_defconfig               |    1 +
 arch/arm/mach-imx/clk-imx27.c                      |    7 +-
 arch/arm/mach-imx/clk-imx31.c                      |   15 +++-
 arch/arm/mach-imx/clk-imx35.c                      |    4 +-
 arch/arm/mach-imx/imx31-dt.c                       |   17 +---
 7 files changed, 129 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx31-clock.txt
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
