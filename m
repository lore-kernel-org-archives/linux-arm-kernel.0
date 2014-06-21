From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 21 Jun 2014 16:50:06 +0800
Subject: [GIT PULL] ARM: imx: fixes for 3.16
Message-ID: <20140621085005.GB16239@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the i.MX fixes I queued for 3.16-rc.  There are a couple of
updates to the Cubox-i which were omitted from the merge window because
of dependency issue.  We'd like to get them in as well at this early
-rc stage.  Please consider to pull.  Thanks.

Shawn

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-3.16

for you to fetch changes up to 7d278f271c082530e6841e40bb47942d526d9b4e:

  ARM: dts: imx51-eukrea-mbimxsd51-baseboard: unbreak esdhc. (2014-06-21 15:54:06 +0800)

----------------------------------------------------------------
The i.MX fixes for 3.16:
 - Use GPIO for card CD/WP on imx51-babbage and eukrea-mbimxsd51,
   because controller base CD/WP is not working in esdhc driver due to
   runtime PM support
 - A couple of random ventana gw5xxx board fixes
 - Add IMX_IPUV3_CORE back to defconfig, which gets lost when moving
   IPUv3 driver out of staging tree
 - Fix enet/fec clock selection on imx6sl
 - Fix display node on imx53-m53evk board
 - A couple of Cubox-i updates from Russell, which were omitted from
   the merge window due to dependency

----------------------------------------------------------------
Denis Carikli (1):
      ARM: dts: imx51-eukrea-mbimxsd51-baseboard: unbreak esdhc.

Fabio Estevam (1):
      ARM: imx_v6_v7_defconfig: Enable CONFIG_IMX_IPUV3_CORE

Fugang Duan (2):
      ARM: imx6sl: add missing enet clock for imx6sl
      ARM: dts: imx6sl: correct the fec ipg clock source

Marek Vasut (2):
      ARM: dts: mx5: Fix IPU port node placement
      ARM: dts: mx5: Move the display out of soc {} node

Philipp Zabel (1):
      ARM: dts: imx6qdl-gw5xxx: Fix Linear Technology vendor prefix

Russell King (2):
      ARM: dts: cubox-i: add support for PWM-driven front panel LED
      ARM: dts: hummingboard/cubox-i: move usb otg configuration to platform level

Sascha Hauer (1):
      ARM: dts: imx51-babbage: Fix esdhc setup

Tim Harvey (2):
      ARM: dts: imx6: ventana: fix include typo
      ARM: dts: imx6: ventana: correct gw52xx sgtl5000 clock source

 arch/arm/boot/dts/imx51-babbage.dts                | 10 +++---
 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  |  4 +--
 arch/arm/boot/dts/imx53-m53evk.dts                 | 40 ++++++++++------------
 arch/arm/boot/dts/imx6dl-hummingboard.dts          | 10 ++++++
 arch/arm/boot/dts/imx6q-gw51xx.dts                 |  2 +-
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi             | 27 +++++++++++++++
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi              |  2 +-
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              |  4 +--
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |  2 +-
 arch/arm/boot/dts/imx6qdl-microsom.dtsi            | 13 -------
 arch/arm/boot/dts/imx6sl.dtsi                      |  2 +-
 arch/arm/configs/imx_v6_v7_defconfig               |  1 +
 arch/arm/mach-imx/clk-imx6sl.c                     |  1 +
 include/dt-bindings/clock/imx6sl-clock.h           |  3 +-
 14 files changed, 73 insertions(+), 48 deletions(-)
