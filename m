From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 16 Nov 2012 15:31:54 +0800
Subject: [GIT PULL] imx device tree changes for 3.8
Message-ID: <20121116073152.GF2941@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 68b25325a7fd290b5e472bba0df9cbe8c1a81d8f:

  ARM: imx: select HAVE_IMX_SRC when SMP is enabled (2012-10-23 15:37:51 +0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-dt-3.8

for you to fetch changes up to 96efb44e471250592ee865ce5b870bc6f860921f:

  ARM: imx6q: select ARM and PL310 errata (2012-11-16 14:52:29 +0800)

----------------------------------------------------------------
It's based on imx/multiplatform branch.  Most of them are dts changes.
There are also a few imx6 improvement patches in there.

----------------------------------------------------------------
Fabio Estevam (3):
      ARM: dts: imx53-qsb: Use pinctrl for gpio-led
      ARM: dts: imx53-qsb: Make DA9053 regulator functional
      ARM: dts: imx6q-sabreauto: Add basic support

Liu Ying (1):
      ARM: dts: imx6q-sabresd: add volume up/down gpio keys

Roland Stigge (1):
      ARM: dts: imx53: pinctl update

Sascha Hauer (2):
      ARM i.MX dtsi: Add default bus-width property for esdhc controller
      ARM i.MX dts: Consistently add labels to devicenodes

Shawn Guo (5):
      ARM: imx6q: let users input debug uart port number
      ARM: dts: imx6q: enable snvs lp rtc
      ARM: imx: enable cpufreq for imx6q
      ARM: imx6q: print silicon version on boot
      ARM: imx6q: select ARM and PL310 errata

 Documentation/devicetree/bindings/arm/fsl.txt |    4 +
 arch/arm/Kconfig.debug                        |   26 +++---
 arch/arm/boot/dts/Makefile                    |    1 +
 arch/arm/boot/dts/imx27.dtsi                  |    5 +-
 arch/arm/boot/dts/imx51.dtsi                  |   43 +++++-----
 arch/arm/boot/dts/imx53-qsb.dts               |   62 ++++++++++----
 arch/arm/boot/dts/imx53.dtsi                  |   92 +++++++++++++++-----
 arch/arm/boot/dts/imx6q-sabreauto.dts         |   64 ++++++++++++++
 arch/arm/boot/dts/imx6q-sabresd.dts           |   18 ++++
 arch/arm/boot/dts/imx6q.dtsi                  |  114 +++++++++++++++----------
 arch/arm/include/debug/imx.S                  |   20 ++++-
 arch/arm/mach-imx/Kconfig                     |   11 +++
 arch/arm/mach-imx/clk-imx6q.c                 |    1 +
 arch/arm/mach-imx/lluart.c                    |   28 +++---
 arch/arm/mach-imx/mach-imx6q.c                |   35 ++++++++
 arch/arm/mach-imx/mx6q.h                      |    4 -
 16 files changed, 389 insertions(+), 139 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6q-sabreauto.dts
