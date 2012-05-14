From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Mon, 14 May 2012 14:19:48 +0530
Subject: [PATCHv10 00/10] I2C fixes
Message-ID: <1336985398-3291-1-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The patch series does the following

- Warn fixes if CONFIG_PM_RUNTIME is not selected.
- In case of i2c remove register access was done without any
 get_sync fix the same.
- Folds a patch from Tasslehoff to prevent any merge conflicts.
- Prevents the XDUF flag to be set if the underflow condition is not met.
- As per discussion in [1] .Adds a patch to rename the 1p153 errata and
 use the unique id instead as the section number in the recent errata
 docs has changed.

v9:
Fix the comments from Wolfram Sang
Also update the patches with comments.

[1] http://www.spinics.net/lists/linux-i2c/msg07607.html

Tested on omap4sdp and omap3sdp.
The following changes since commit 9ff00d58a915b6747ba2e843ab2d04c712b4dc32:

  Merge tag 'for-linus-3.4-20120513' of git://git.infradead.org/linux-mtd (2012-05-13 11:33:09 -0700)

are available in the git repository at:

  git://gitorious.org/linus-tree/linus-tree.git i2c_omap-fixes

Shubhrajyoti D (9):
      I2C: OMAP: make omap_i2c_unidle/idle functions depend on CONFIG_PM_RUNTIME
      I2C: OMAP: Fix the mismatch of pm_runtime enable and disable
      I2C: OMAP: Fix the interrupt clearing in OMAP4
      I2C: OMAP: Prevent the register access after pm_runtime_put in probe
      I2C: OMAP: Don't check if wait_for_completion_timeout() returns less than zero
      I2C: OMAP: Fix the crash in i2c remove
      I2C: OMAP: Handle error check for pm runtime
      I2C: OMAP: Do not set the XUDF(Transmit underflow) if the underflow is not reached
      I2C: OMAP: Rename the 1p153 to the erratum id i462

Tasslehoff Kjappfot (1):
      I2C: OMAP: prevent the overwrite of the errata flags

 drivers/i2c/busses/i2c-omap.c |  127 ++++++++++++++++++++---------------------
 1 files changed, 62 insertions(+), 65 deletions(-)

-- 
1.7.5.4
