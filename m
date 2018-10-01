From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 1 Oct 2018 10:39:25 +0800
Subject: [GIT PULL] i.MX fixes for 4.19, round 2
Message-ID: <20181001023923.GQ26692@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.19-2

for you to fetch changes up to 4d8d4712e47c028306149bda04b79f70325aefb0:

  soc: imx: gpc: set DMA mask for PD platform devices (2018-09-26 10:38:38 +0800)

----------------------------------------------------------------
i.MX fixes for 4.19, round 2:
 - There appears an uninitialized DMA mask warning on i.MX GPC driver
   with 4.19-rc kernel.  Set the DMA mask for powerdomain platform
   device to fix the warning given by device core.
 - i.MX53 QSB board stops working when cpufreq driver is enabled,
   because the default OPP table has the maximum CPU frequency at
   1.2GHz, while the board is only capable of running 1GHz.  Fix up
   the OPP table for the board to get it work with cpufreq driver.

----------------------------------------------------------------
Lucas Stach (1):
      soc: imx: gpc: set DMA mask for PD platform devices

Sascha Hauer (1):
      ARM: dts: imx53-qsb: disable 1.2GHz OPP

 arch/arm/boot/dts/imx53-qsb-common.dtsi | 11 +++++++++++
 drivers/soc/imx/gpc.c                   |  1 +
 2 files changed, 12 insertions(+)
