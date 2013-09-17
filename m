From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 17 Sep 2013 23:27:35 +0800
Subject: [GIT PULL] ARM: imx: fixes for 3.12
Message-ID: <20130917152733.GB30069@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-fixes-3.12

for you to fetch changes up to 538bcbe251d621aa19c46babafd01ede8fb6ddde:

  ARM: dts: imx6q: fix the wrong offset of the Pad Mux register (2013-09-17 10:04:25 +0800)

----------------------------------------------------------------
The imx fixes for 3.12:

* A couple of clock driver and device tree fixes
* A bug fix for clk-fixup-mux to get imx6sl back to boot
* A L2 cache setting fix for imx6q
* One pinctrl macro fix for UART2 DTE entries

----------------------------------------------------------------
Arnaud Patard (1):
      ARM: imx51.dtsi: fix PATA device clock

Fabio Estevam (1):
      ARM: mach-imx: clk-imx51-imx53: Fix 'spdif1_pred' clock registration

Gwenhael Goavec-Merou (1):
      ARM: imx27.dtsi: fix CSPI PER clock id

Huang Shijie (1):
      ARM: dts: imx6q: fix the wrong offset of the Pad Mux register

Jason Liu (1):
      ARM: imx: i.mx6d/q: disable the double linefill feature of PL310

Shawn Guo (1):
      ARM: imx: initialize clk_init_data.flags for clk-fixup-mux

 arch/arm/boot/dts/imx27.dtsi        |    6 +++---
 arch/arm/boot/dts/imx51.dtsi        |    2 +-
 arch/arm/boot/dts/imx6q-pinfunc.h   |    4 ++--
 arch/arm/mach-imx/clk-fixup-mux.c   |    1 +
 arch/arm/mach-imx/clk-imx51-imx53.c |    2 +-
 arch/arm/mach-imx/system.c          |   11 +++++++++++
 6 files changed, 19 insertions(+), 7 deletions(-)
