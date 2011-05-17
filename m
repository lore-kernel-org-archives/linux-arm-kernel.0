From: khilman@ti.com (Kevin Hilman)
Date: Tue, 17 May 2011 16:31:36 +0200
Subject: [PATCH 0/2] I2C: OMAP: clean up runtime PM usage
Message-ID: <1305642698-15338-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current usage of runtime PM is not quite correct.  The actual
idle/unidle of the I2C hardware should not happen until the runtime PM
callbacks are called.

Clean up by using runtime PM callbacks to call idle/unidle functions
and also replace usage of dev->idle check by pm_runtime_suspended() check.

Kevin Hilman (2):
  I2C: OMAP: remove unneccesary use of pdev
  I2C: OMAP: remove dev->idle, use usage counting provided by runtime
    PM

 drivers/i2c/busses/i2c-omap.c |   70 +++++++++++++++++++++--------------------
 1 files changed, 36 insertions(+), 34 deletions(-)

-- 
1.7.3.4
