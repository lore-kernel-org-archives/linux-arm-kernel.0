From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Tue, 14 Jun 2016 18:39:09 +0300
Subject: [PATCH 00/10] i2c: designware-platdrv: Some improvments related
 to PM
In-Reply-To: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
References: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1465918749.30123.70.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-06-14 at 17:07 +0200, Ulf Hansson wrote:
> Here's a couple changes for the i2c-designware driver. Most of them a
> related to
> the support for runtime PM and system PM, but there's also a few that
> improves
> some error handling.
> 
> I have tested these on Hisilicon Linaro 96-board (hi6220). I used a
> couple local
> changes to enable the power-key to act as a wakeup in system PM
> suspend state.
> If anyone are interested about those as well, I am happy to share
> them.

I know Jarkko spent a lot to understand PM flow in this driver.

My overall feelings after brief reading of the series you fixed a
particular problem with your device or flow, which might have broken the
half of current users. So, I wouldn't take this without Tested-by tags
of (almost) all active stakeholders.

> 
> Ulf Hansson (10):
> ? i2c: designware-platdrv: Return error in ->probe() when clk ungate
> ????fails
> ? i2c: designware-platdrv: Gate clk in error path in ->probe()
> ? i2c: designware-platdrv: Unconditionally enable runtime PM
> ? i2c: designware-platdrv: Disable autosuspend in error path in
> ????->probe()
> ? i2c: designware-platdrv: Fix clk gating in ->remove()
> ? i2c: designware-platdrv: Update runtime PM last busy mark in
> ->probe()
> ? i2c: designware-platdrv: Re-init the HW when resuming
> ? i2c: designware-platdrv: Check return value from
> clk_prepare_enable()
> ? i2c: designware-platdrv: Simplify code by using dev_get_drvdata()
> ? i2c: designware-platdrv: Rework system PM support
> 
> ?drivers/i2c/busses/i2c-designware-platdrv.c | 106 +++++++++++++----
> -----------
> ?1 file changed, 50 insertions(+), 56 deletions(-)
> 

-- 

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
