From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 29 Jan 2017 12:06:39 +0800
Subject: [GIT PULL 1/5] i.MX non-critical DT fixes for 4.11
Message-ID: <1485662803-31235-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:

  Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-nc-4.11

for you to fetch changes up to 8b649e426336d7d4800ff9c82858328f4215ba01:

  ARM: dts: imx53-qsb-common: fix FEC pinmux config (2017-01-29 10:05:33 +0800)

----------------------------------------------------------------
i.MX non-critical device tree fixes for 4.11:
 - A couple of fixes on anatop regulator voltage and constraints
   according to hardware datasheet.
 - Correct FEC interrupt routing for i.MX6QP which has got the hardware
   bug found on i.MX6Q fixed.
 - Remove unit address from i.MX6 LDB device node to fix DTC warning.
 - A fix on imx53-qsb board FEC pinmux config to remove the dependency
   on firmware for setting up pins.
 - A series from Sascha to fix LPSR pins for i.MX7 boards.

----------------------------------------------------------------
Lucas Stach (4):
      ARM: imx6: fix min/max voltage of anatop 2p5 regulator
      ARM: imx6: fix regulator constraints on anatop 1p1 and 2p5
      ARM: imx6qp: adapt DT to changed FEC interrupts
      ARM: imx6: remove unit address from LDB node

Patrick Bruenn (1):
      ARM: dts: imx53-qsb-common: fix FEC pinmux config

Sascha Hauer (4):
      ARM: dts: imx7s-warp: Fix watchdog pinmux
      ARM: dts: imx7d-sdb: Fix watchdog and pwm pinmux
      ARM: dts: imx7d-cl-som: Fix OTG power pinctrl
      ARM: dts: imx7: Add "LPSR" to LPSR iomux pin names

 arch/arm/boot/dts/imx53-qsb-common.dtsi |  20 +++---
 arch/arm/boot/dts/imx6qdl.dtsi          |  12 ++--
 arch/arm/boot/dts/imx6qp.dtsi           |   6 ++
 arch/arm/boot/dts/imx7-colibri.dtsi     |  16 ++---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts |  14 ++--
 arch/arm/boot/dts/imx7d-nitrogen7.dts   |  14 ++--
 arch/arm/boot/dts/imx7d-pinfunc.h       | 110 ++++++++++++++++----------------
 arch/arm/boot/dts/imx7d-sdb.dts         |  24 +++----
 arch/arm/boot/dts/imx7s-warp.dts        |   4 +-
 9 files changed, 116 insertions(+), 104 deletions(-)
