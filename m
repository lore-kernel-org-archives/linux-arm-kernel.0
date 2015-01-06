From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 6 Jan 2015 21:21:21 +0800
Subject: [GIT PULL] ARM: imx: fixes for 3.19
Message-ID: <20150106132120.GA21729@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-3.19

for you to fetch changes up to 7a9f0604bd56936b2b18f49824e0e392dc7878c3:

  ARM: dts: imx51-babbage: Fix ULPI PHY reset modelling (2015-01-06 20:25:58 +0800)

----------------------------------------------------------------
The i.MX fixes for 3.19:
 - One fix for incorrect i.MX25 SPI1 clock assignment in device tree,
   which causes system hang when accessing SPI1.
 - Correct i.MX6SX QSPI parent clock configuration to fix a kernel Oops.
 - Fix ULPI PHY reset modelling on imx51-babbage board to remove the
   dependency on bootloader for USB3317 ULPI PHY reset.
 - Correct video divider setting on i.MX6Q rev T0 1.0 to fix the issue
   that HDMI is not working at high resolution on T0 1.0.
 - One incremental fix for CODA960 VPU enabling in device tree to
   correct interrupt order.
 - LS1021A SCFG block works in BE mode, add device tree property
   big-endian to make it right.

----------------------------------------------------------------
Fabio Estevam (3):
      ARM: dts: imx25: Fix the SPI1 clocks
      ARM: imx6sx: Set PLL2 as parent of QSPI clocks
      ARM: dts: imx51-babbage: Fix ULPI PHY reset modelling

Gary Bisson (1):
      ARM: clk-imx6q: fix video divider for rev T0 1.0

Philipp Zabel (1):
      ARM: dts: imx6qdl: Fix CODA960 interrupt order

Xiubo Li (1):
      ARM: ls1021a: dtsi: add 'big-endian' property for scfg node

 arch/arm/boot/dts/imx25.dtsi        |  2 +-
 arch/arm/boot/dts/imx51-babbage.dts | 22 +++++-----------------
 arch/arm/boot/dts/imx6qdl.dtsi      |  4 ++--
 arch/arm/boot/dts/ls1021a.dtsi      |  1 +
 arch/arm/mach-imx/clk-imx6q.c       |  2 +-
 arch/arm/mach-imx/clk-imx6sx.c      |  3 +++
 6 files changed, 13 insertions(+), 21 deletions(-)
