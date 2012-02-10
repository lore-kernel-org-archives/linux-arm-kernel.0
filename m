From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Fri, 10 Feb 2012 19:29:55 +0530
Subject: [PATCH 00/10] I2C updates 
Message-ID: <1328882405-15284-1-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series colates the various i2c updates into
a series.  Since it is collection of various patches
the version info is not retained, however most of them undergone
multiple versions.

This is rebased to linus head commit 63082402968f4b73f10b28a8ac1f3da821aeb82d

The patch series does the following 

- Warn fixes if CONFIG_PM_RUNTIME is not selected.
- I2C register restore only if context if the context is lost
- Bus busy recovery mechanism.
- the reset is not done in init.

Tested on omap4sdp and omap3sdp. 


Cc: Kevin Hilman <khilman@ti.com>
Cc: Ben Dooks <ben-linux@fluff.org>

Jon Hunter (1):
  I2C: OMAP: Correct I2C revision for OMAP3

Shubhrajyoti D (8):
  I2C : OMAP : make omap_i2c_unidle/idle functions depend on
    CONFIG_PM_RUNTIME
  OMAP : I2C : Remove reset at init
  OMAP: I2C: I2C register restore only if context is lost
  OMAP: I2C: Fix the interrupt clearing in OMAP4
  OMAP: I2C: Fix the mismatch of pm_runtime enable and disable
  OMAP: I2C: Optimise the remove code
  OMAP: I2C: Fix the error handling
  I2C: OMAP: Don't check if wait_for_completion_timeout() returns less
    than zero

Vikram Pandita (1):
  I2C: OMAP: Recover from Bus Busy condition

 drivers/i2c/busses/i2c-omap.c |  173 ++++++++++++++++++++++++-----------------
 1 files changed, 101 insertions(+), 72 deletions(-)
