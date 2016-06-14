From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Tue, 14 Jun 2016 18:35:16 +0300
Subject: [PATCH 10/10] i2c: designware-platdrv: Rework system PM support
In-Reply-To: <1465916848-8207-11-git-send-email-ulf.hansson@linaro.org>
References: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
 <1465916848-8207-11-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1465918516.30123.66.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-06-14 at 17:07 +0200, Ulf Hansson wrote:
> The current code that deploys the system PM support relies on the
> "direct_complete" feature supported by the PM core. The goal is to
> avoid
> performing unnecessary operations during the system PM sequence.
> 

> 
> ?static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
> -	.prepare = dw_i2c_plat_prepare,
> -	.complete = dw_i2c_plat_complete,
> -	SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend,
> dw_i2c_plat_resume)
> -	SET_RUNTIME_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume,
> NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(dw_i2c_plat_runtime_suspend,
> +			dw_i2c_plat_runtime_resume,
> +			NULL)
> ?};

UNIVERSAL_PM_OPS ?

-- 

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
