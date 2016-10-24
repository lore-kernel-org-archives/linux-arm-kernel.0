From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 24 Oct 2016 22:06:22 +0800
Subject: [GIT PULL] i.MX fixes for 4.9
Message-ID: <20161024140622.GM30578@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.9

for you to fetch changes up to 4edd601c5a9c5094daa714e65063e623826f3bcc:

  ARM: imx: mach-imx6q: Fix the PHY ID mask for AR8031 (2016-10-24 21:26:01 +0800)

----------------------------------------------------------------
The i.MX fixes for 4.9:
 - A couple of patches from Fabio to fix the GPC power domain regression
   which is caused by PM Domain core change 0159ec670763dd
   ("PM / Domains: Verify the PM domain is present when adding a
   provider"), and a related kernel crash seen with multi_v7_defconfig
   build.
 - Correct the PHY ID mask for AR8031 to match phy driver code.
 - Apply new added timer erratum A008585 for LS1043A and LS2080A SoC.
 - Correct vf610 global timer IRQ flag to avoid warning from gic driver
   after commit 992345a58e0c ("irqchip/gic: WARN if setting the
   interrupt type for a PPI fails").

----------------------------------------------------------------
Fabio Estevam (3):
      ARM: imx: gpc: Initialize all power domains
      ARM: imx: gpc: Fix the imx_gpc_genpd_init() error path
      ARM: imx: mach-imx6q: Fix the PHY ID mask for AR8031

Scott Wood (1):
      arm64: dts: Add timer erratum property for LS2080A and LS1043A

Stefan Agner (1):
      ARM: dts: vf610: fix IRQ flag of global timer

 arch/arm/boot/dts/vf500.dtsi                   |  2 +-
 arch/arm/mach-imx/gpc.c                        | 15 ++++++++++++---
 arch/arm/mach-imx/mach-imx6q.c                 |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  1 +
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi |  1 +
 5 files changed, 16 insertions(+), 5 deletions(-)
