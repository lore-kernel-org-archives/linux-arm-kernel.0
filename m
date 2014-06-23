From: yuvaraj.cd@gmail.com (Yuvaraj Kumar C D)
Date: Mon, 23 Jun 2014 16:15:18 +0530
Subject: [PATCH 0/3] Adding UHS support for dw_mmc driver
Message-ID: <1403520321-2431-1-git-send-email-yuvaraj.cd@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds UHS support for dw_mmc driver.
Patch[1] reworks the handling of vmmc and vqmmc regulators.
Patch[2] handles the case where in some boards uses built-in CD line for
card detection and connected to a same voltage domain as of the IO rails.
Patch[3] was taken from chrome tree originally developed by Doug Anderson.

These patches were tested on exynos based chromebook with 3.16-rc1.

Doug Anderson (1):
  mmc: dw_mmc: Support voltage changes

Yuvaraj Kumar C D (2):
  mmc: dw_mmc: use mmc_regulator_get_supply to handle regulators
  mmc: dw_mmc: Dont cut off vqmmc and vmmc

 drivers/mmc/host/dw_mmc.c  |  239 +++++++++++++++++++++++++++++++++++---------
 drivers/mmc/host/dw_mmc.h  |    7 +-
 include/linux/mmc/dw_mmc.h |    2 +
 3 files changed, 201 insertions(+), 47 deletions(-)

-- 
1.7.10.4
