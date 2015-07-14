From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 14 Jul 2015 23:39:51 +0800
Subject: [GIT PULL] ARM: imx: fixes for 4.2
Message-ID: <20150714153951.GJ4119@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.2

for you to fetch changes up to d438462c20a300139c2e5e65b96cadaa21b58d9a:

  ARM: imx6: gpc: always enable PU domain if CONFIG_PM is not set (2015-07-08 22:52:08 +0800)

----------------------------------------------------------------
The i.MX fixes for 4.2:
 - Correct compatible string for i.MX27 GPT which actually shares the
   same programming model as i.MX21 GPT rather than i.MX1 one.
 - Add missing #io-channel-cells property for i.MX23 LRADC device, which
   is required for the device to be an IIO provider.
 - Correct HSYNC/VSYNC pins and add ddc-i2c-bus property for TVE device
   on imx53-qsb to work properly.
 - Always enable PU domain if CONFIG_PM is not set.  This fixes a couple
   of failure scenarios which will hang the system if one of the devices
   in the PU domain is accessed.

----------------------------------------------------------------
Fabio Estevam (1):
      ARM: dts: imx27: Adjust the GPT compatible string

Lucas Stach (1):
      ARM: imx6: gpc: always enable PU domain if CONFIG_PM is not set

Philipp Zabel (1):
      ARM: dts: imx53-qsb: fix TVE entry

Stefan Wahren (1):
      ARM: dts: mx23: fix iio-hwmon support

 arch/arm/boot/dts/imx23.dtsi            |  1 +
 arch/arm/boot/dts/imx27.dtsi            | 12 ++++++------
 arch/arm/boot/dts/imx53-qsb-common.dtsi |  5 +++--
 arch/arm/mach-imx/gpc.c                 | 27 ++++++---------------------
 4 files changed, 16 insertions(+), 29 deletions(-)
