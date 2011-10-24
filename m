From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 24 Oct 2011 15:28:45 +0200
Subject: [PATCH V2 0/3] Clearify code paths for how to modify the power
	register
Message-ID: <1319462928-14892-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the set_ios function there has been a mess of how the power register
can be modified. One part, especially strange was related to the use of 
the vdd_handler.

V2 changes:
	-Rebased to remove dependency to other patch serie for mmci called
	"mmc: mmci: Improvements and bugfixes for SDIO".
	-Fixed minor review comments.

Sebastian Rasmussen (1):
  mmc: mmci: Put power register deviations in variant data

Ulf Hansson (2):
  mmc: mmci: Provide option to configure bus signal direction
  mmc: mmci: Change vdd_handler to a generic ios_handler

 arch/arm/mach-ux500/board-mop500-sdi.c |   21 +++++--------
 drivers/mmc/host/mmci.c                |   49 ++++++++++++++++++++++++++-----
 drivers/mmc/host/mmci.h                |   10 ------
 include/linux/amba/mmci.h              |   22 ++++++++++++--
 4 files changed, 68 insertions(+), 34 deletions(-)

-- 
1.7.5.4
