From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 4 Nov 2014 19:20:27 +0800
Subject: [GIT PULL] ARM: imx: fixes for 3.18, 2nd round
Message-ID: <20141104112026.GL10821@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This is the second round of i.MX fixes for 3.18.  The clk-vf610 fix is
relatively big, because it needs some adaption to the change made by
offending commit dc4805c2e78b (ARM: imx: remove ENABLE and BYPASS bits
from clk-pllv3 driver).  And it should have been sent to you for earlier
-rc inclusion, but unfortunately it got delayed for some time because
Stefan wasn't aware of my email address change.

Please consider to send them for 3.18 inclusion.  Thanks.

Shawn

The following changes since commit 0df1f2487d2f0d04703f142813d53615d62a1da4:

  Linux 3.18-rc3 (2014-11-02 15:01:51 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-3.18-2

for you to fetch changes up to 89fbec5b97fbcf08db3a9cd93a340f21f95d38b8:

  ARM: imx: Fix the removal of CONFIG_SPI option (2014-11-04 19:00:01 +0800)

----------------------------------------------------------------
The i.MX fixes for 3.18, 2nd round:
 - Fix a regression on Vybrid platform which is caused by commit
   dc4805c2e78b (ARM: imx: remove ENABLE and BYPASS bits from clk-pllv3
   driver), and results in a missing configuration on PLL clocks.
 - Fix a regression with i.MX defconfig files where CONFIG_SPI option
   gets lost accidentally.

----------------------------------------------------------------
Fabio Estevam (1):
      ARM: imx: Fix the removal of CONFIG_SPI option

Stefan Agner (1):
      ARM: imx: clk-vf610: define PLL's clock tree

 arch/arm/configs/imx_v4_v5_defconfig    |   1 +
 arch/arm/configs/imx_v6_v7_defconfig    |   1 +
 arch/arm/mach-imx/clk-vf610.c           | 134 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------
 include/dt-bindings/clock/vf610-clock.h |  39 ++++++++++++++++++++++++-------
 4 files changed, 125 insertions(+), 50 deletions(-)
