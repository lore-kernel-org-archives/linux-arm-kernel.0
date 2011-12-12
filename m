From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 12 Dec 2011 16:36:02 +0100
Subject: [PATCH 0/5] mmc: mmci: Improvements and bugfixes for SDIO
Message-ID: <1323704167-10247-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchserie is based upon the below stated patchserie:
mmc: mmci: Improved PM support, cleanup and bugfixes

These patches are all related to the SDIO support. Some patches will
anyway effect the code execution path for non-SDIO and more important
also the "hotpath" for all PIO read transfers. The intent is to try
to affect as little as possible.

Per Forlin (1):
  mmc: mmci: Add constraints on alignment for SDIO

Stefan Nilsson XK (1):
  mmc: mmci: Fix PIO read for small SDIO packets

Ulf Hansson (3):
  mmc: mmci: Prepare for SDIO before setting up DMA job
  mmc: mmci: Fix incorrect handling of HW flow control for SDIO
  mmc: mmci: Support any block sizes for ux500v2 variant

 drivers/mmc/host/mmci.c |  120 +++++++++++++++++++++++++++++++++++-----------
 drivers/mmc/host/mmci.h |    7 +++
 2 files changed, 98 insertions(+), 29 deletions(-)

-- 
1.7.5.4
