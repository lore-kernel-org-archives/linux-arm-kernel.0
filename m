From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 25 Nov 2015 21:25:17 +0800
Subject: [GIT PULL] ARM: imx: fixes for 4.4
Message-ID: <20151125132517.GI11999@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.4

for you to fetch changes up to 897ed0ca5979f103b8de3c09bcca2ae4860eb5a5:

  ARM: dts: vfxxx: Fix dspi[01] spi-num-chipselects. (2015-11-24 17:38:42 +0800)

----------------------------------------------------------------
The i.MX fixes for 4.4:
- Add missing .irq_set_type for i.MX GPC irq_chip.  It fixes an issue
  that device IRQ type setting doesn't match the one specified in device
  tree, since stacked IRQ domain is adopted in GPC driver.
- Fix the wrong spi-num-chipselects settings for Vybrid DSPI devices.
- Fix a merge error in Vybrid dts regarding to ADC device property
  fsl,adck-max-frequency

----------------------------------------------------------------
Anson Huang (1):
      ARM: imx: add platform irq type setting in gpc

Cory Tusar (1):
      ARM: dts: vfxxx: Fix dspi[01] spi-num-chipselects.

Sanchayan Maity (1):
      ARM: dts: vfxxx: Fix erroneous property in esdhc0 node

 arch/arm/boot/dts/vfxxx.dtsi | 8 ++++----
 arch/arm/mach-imx/gpc.c      | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)
