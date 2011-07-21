From: zhangfei.gao@marvell.com (Zhangfei Gao)
Date: Thu, 21 Jul 2011 10:34:31 +0800
Subject: [PATCH] sdio add regulator vsdio to dynamic control sdio power
Message-ID: <1311215673-2489-1-git-send-email-zhangfei.gao@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sdio client has the requirement to dynamically power on/off
With regulator vsdio, so sdio client power on/off when mmc_power_up/down
Add brownstone support sdio with regulator vsdio, 

Zhangfei Gao (2):
  mmc: sdio add regulator vsdio
  ARM: mmp2: support sdio with regulator vsdio

 arch/arm/mach-mmp/brownstone.c |   60 ++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.c       |   24 ++++++++++++++++
 include/linux/mmc/sdhci.h      |    2 +
 3 files changed, 84 insertions(+), 2 deletions(-)
