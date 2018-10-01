From: shawnguo@kernel.org (Shawn Guo)
Date: Mon,  1 Oct 2018 15:19:59 +0800
Subject: [GIT PULL 1/5] i.MX drivers updates for 4.20
Message-ID: <20181001072003.16238-1-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-drivers-4.20

for you to fetch changes up to 8d8e3b7d8f06f69005d829d4a195b00ef976004b:

  soc: imx: gpcv2: Switch to SPDX identifier (2018-10-01 13:24:15 +0800)

----------------------------------------------------------------
i.MX drivers update for 4.20:
 - A couple of patches from Anson to update variable and macro naming
   in GPCv2 driver, as a preparation of reusing the driver on i.MX8.
 - Switch GPC/GPCv2 drivers to use SPDX identifier for licence claiming.
 - Clean up the unnecessary DT node name NULL pointer checking from
   imx-weim driver, since it can never be NULL at all.
 - A couple of improvements on GPC driver from Sven Schmitt to correct
   PDN register and use GPC_PGC_DOMAIN_* indexes for consistency.

----------------------------------------------------------------
Anson Huang (2):
      soc: imx: gpcv2: use A_CORE instread of A7 for more i.MX platforms
      soc: imx: gpcv2: make pgc driver more generic for other i.MX platforms

Fabio Estevam (2):
      soc: imx: gpc: Switch to SPDX identifier
      soc: imx: gpcv2: Switch to SPDX identifier

Rob Herring (1):
      bus: imx-weim: drop unnecessary DT node name NULL check

Sven Schmitt (2):
      soc: imx: gpc: fix PDN delay
      soc: imx: gpc: use GPC_PGC_DOMAIN_* indexes

 drivers/bus/imx-weim.c  |   3 --
 drivers/soc/imx/gpc.c   |  26 ++++++-------
 drivers/soc/imx/gpcv2.c | 100 ++++++++++++++++++++++++++----------------------
 3 files changed, 66 insertions(+), 63 deletions(-)
