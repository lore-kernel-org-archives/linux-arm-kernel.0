From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 11 Dec 2015 21:59:49 +0800
Subject: [GIT PULL] ARM: imx: fixes for 4.4, 2nd round
Message-ID: <20151211135948.GH11252@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 897ed0ca5979f103b8de3c09bcca2ae4860eb5a5:

  ARM: dts: vfxxx: Fix dspi[01] spi-num-chipselects. (2015-11-24 17:38:42 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.4-2

for you to fetch changes up to 9c17190595840b4ed30e8d5f286636ceb28aae4f:

  ARM: dts: vf610: use reset values for L2 cache latencies (2015-12-11 21:32:47 +0800)

----------------------------------------------------------------
The i.MX fixes for 4.4, 2nd round:
- Fix vf610 SAI clock configuration bug which is discovered by the newly
  added master mode support in SAI audio driver.
- Fix buggy L2 cache latency values in vf610 device trees, which may
  cause system hang when cpu runs at a higher frequency.

----------------------------------------------------------------
Stefan Agner (3):
      ARM: imx: clk-vf610: fix SAI clock tree
      ARM: dts: vf610: fix clock definition for SAI2
      ARM: dts: vf610: use reset values for L2 cache latencies

 arch/arm/boot/dts/vf610-colibri.dtsi | 5 -----
 arch/arm/boot/dts/vf610.dtsi         | 2 +-
 arch/arm/boot/dts/vfxxx.dtsi         | 6 ++++--
 drivers/clk/imx/clk-vf610.c          | 8 ++++----
 4 files changed, 9 insertions(+), 12 deletions(-)
