From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 3 Dec 2014 10:27:22 +0000
Subject: [PATCH v3 1/3] power: reset: adjust priority of simple syscon
 reboot driver
In-Reply-To: <1417540320-2385-2-git-send-email-stefan@agner.ch>
References: <1417540320-2385-1-git-send-email-stefan@agner.ch>
 <1417540320-2385-2-git-send-email-stefan@agner.ch>
Message-ID: <20141203102722.GB21310@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 02, 2014 at 05:11:58PM +0000, Stefan Agner wrote:
> Currently, all restart handler use the priority 128, including
> watchdogs. Probably most SoC have a watchdog, and some of them
> register it also as a restart handler. But if a SoC specifies
> a dedicated reboot capability using this syscon driver, this is
> usually the preferred reboot method. Hence, raise the priority
> of this driver to 192.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

This looks good to me.

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  drivers/power/reset/syscon-reboot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/reset/syscon-reboot.c b/drivers/power/reset/syscon-reboot.c
> index 815b901..c4049f4 100644
> --- a/drivers/power/reset/syscon-reboot.c
> +++ b/drivers/power/reset/syscon-reboot.c
> @@ -68,7 +68,7 @@ static int syscon_reboot_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  
>  	ctx->restart_handler.notifier_call = syscon_restart_handle;
> -	ctx->restart_handler.priority = 128;
> +	ctx->restart_handler.priority = 192;
>  	err = register_restart_handler(&ctx->restart_handler);
>  	if (err)
>  		dev_err(dev, "can't register restart notifier (err=%d)\n", err);
> -- 
> 2.1.3
> 
> 
