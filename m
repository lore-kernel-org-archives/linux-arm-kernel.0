From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 5 Dec 2011 18:35:46 +0100
Subject: [PATCH 00/14] mmc: mmci: Improved PM support, cleanup and bugfixes
Message-ID: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchserie is based on Linux 3.2-rc3 and contains the following:

Patch 1 -> 4:
Minor changes for bugs and some performance optimizations.
Previously sent to the mailing list.

Patch 5 -> 7:
Minor changes affecting how to handle a levelshifter.
Previously sent to the mailing list.

Patch 8:
Bugfix for dma. Previously sent to the mailing list, ongoing discussion.

Patch 9 -> 14:
Improvement of PM support.
An earlier patch around extending the PM runtime support for mmci has been
discussed on the mailing list rather recently. Those review comment's
has been considered in these patches.


This patchstack is becomming quite big. Hopefully it should still be possible
review each piece separate. Those patches that earlier have been uploaded into
Russell's patchtracker will be replaced with these new rebased versions.


Sebastian Rasmussen (1):
  mmc: mmci: Put power register deviations in variant data

Ulf Hansson (13):
  mmc: mmci: Support MMC_PM_KEEP_POWER
  mmc: mmci: Fixup handling of MCI_STARTBITERR
  mmc: mmci: Increase max_segs from 16 to 128
  mmc: mmci: Do not release spinlock in request_end
  mmc: mmci: Provide option to configure bus signal direction
  mmc: mmci: Change vdd_handler to a generic ios_handler
  mmc: mmci: Fixup error handling for dma
  mmc: mmci: Change from using legacy suspend
  mmc: mmci: Cache MMCICLOCK and MMCIPOWER register
  mmc: mmci: Fixup use of runtime PM and use autosuspend
  mmc: mmci: Decrease current consumption in suspend
  mmc: mmci: Implement PM runtime callbacks to save power
  mmc: mmci: Use ios_handler to save power

 arch/arm/mach-ux500/board-mop500-sdi.c |   21 +--
 drivers/mmc/host/mmci.c                |  266 ++++++++++++++++++++++++++------
 drivers/mmc/host/mmci.h                |   15 +--
 include/linux/amba/mmci.h              |   22 +++-
 4 files changed, 252 insertions(+), 72 deletions(-)

-- 
1.7.5.4
