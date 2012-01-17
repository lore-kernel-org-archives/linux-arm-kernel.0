From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Tue, 17 Jan 2012 15:34:19 +0100
Subject: [PATCH 0/8] mmc: mmci: Improved PM and SDIO support 
Message-ID: <1326810867-5346-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series replaces previous version of the series below:
	- Improved PM support, cleanup and bugfixes
	- Improvements and bugfixes for SDIO

Patches that were accepted has been removed from the series and the
ones left has been rebased.

Patch 1 to 5:
	- PM patches.
Patch 6 - 8:
	- SDIO patches.

Per Forlin (1):
  mmc: mmci: Add constraints on alignment for SDIO

Ulf Hansson (7):
  mmc: mmci: Cache MMCICLOCK and MMCIPOWER register
  mmc: mmci: Decrease current consumption in suspend
  mmc: mmci: Implement PM runtime callbacks to save power
  mmc: mmci: Use ios_handler to save power
  mmc: mmci: Support MMC_PM_KEEP_POWER
  mmc: mmci: Fix incorrect handling of HW flow control for SDIO
  mmc: mmci: Support any block sizes for ux500v2 variant

 drivers/mmc/host/mmci.c |  251 ++++++++++++++++++++++++++++++++++++++++-------
 drivers/mmc/host/mmci.h |   10 ++-
 2 files changed, 222 insertions(+), 39 deletions(-)

-- 
1.7.5.4
