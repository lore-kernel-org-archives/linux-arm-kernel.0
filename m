From: joshc@codeaurora.org (Josh Cartwright)
Date: Thu, 27 Feb 2014 21:45:47 -0600
Subject: [PATCH v4 5/9] Input: pmic8xxx-pwrkey - Migrate to DT
In-Reply-To: <1393552520-9068-6-git-send-email-sboyd@codeaurora.org>
References: <1393552520-9068-1-git-send-email-sboyd@codeaurora.org>
 <1393552520-9068-6-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140228034547.GE7308@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 27, 2014 at 05:55:16PM -0800, Stephen Boyd wrote:
> The driver is only supported on DT enabled platforms. Convert the
> driver to DT so that it can probe properly.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> --- a/drivers/input/misc/pmic8xxx-pwrkey.c
> +++ b/drivers/input/misc/pmic8xxx-pwrkey.c
> @@ -172,7 +178,7 @@ static int pmic8xxx_pwrkey_probe(struct platform_device *pdev)
>  	}
>  
>  	platform_set_drvdata(pdev, pwrkey);
> -	device_init_wakeup(&pdev->dev, pdata->wakeup);
> +	device_init_wakeup(&pdev->dev, 1);

Is there a particular reason you aren't providing a 'linux,wakeup'
property for pwrkey?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
