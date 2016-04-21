From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Thu, 21 Apr 2016 14:03:34 +0300
Subject: [PATCH v2] i2c: designware-platdrv: fix unbalanced clk enable
 and prepare
In-Reply-To: <1461230811-7495-1-git-send-email-jszhang@marvell.com>
References: <1461230811-7495-1-git-send-email-jszhang@marvell.com>
Message-ID: <1461236614.6620.312.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-04-21 at 17:26 +0800, Jisheng Zhang wrote:
> If i2c_dw_probe() fail, we should disable and unprepare the clk,

clk -> clock, or use function name explicitly.

> otherwise the clk enable and prepare is left unbalanced.
> 

Ditto.

> In dw_i2c_plat_remove(), we'd better to not rely on rpm to disable
> and unprepare the clk since CONFIG_PM may be disabled when configuring

Ditto.

> the kernel. So we explicitly disable and unprepare the clk in

Ditto.

> dw_i2c_plat_remove().


> +	pm_runtime_put_noidle(&pdev->dev);
> ?
> -	pm_runtime_put_sync(&pdev->dev);
> 

This change also needs to be described in the commit message.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
