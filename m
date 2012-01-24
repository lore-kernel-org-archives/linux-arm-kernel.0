From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Tue, 24 Jan 2012 05:02:08 +0000
Subject: [PATCH RFC 1/2] watchdog : omap_wdt : Implement
 WDIOC_GETBOOTSTATUS for omap3+
In-Reply-To: <1327317188-14782-2-git-send-email-shubhrajyoti@ti.com>
References: <1327317188-14782-1-git-send-email-shubhrajyoti@ti.com>
 <1327317188-14782-2-git-send-email-shubhrajyoti@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D12143317901B9@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2012 at 16:43:07, Datta, Shubhrajyoti wrote:
> This patch intends to implement the WDIOC_GETBOOTSTATUS ioctl
> for the omap3 and omap4.
> 

Instead of just returning the register content why not parse 
the RSTST register value and check if it's really a watchdog
reset or not?

> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/watchdog/omap_wdt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index 4b33e3f..5395a4c 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -229,7 +229,7 @@ static long omap_wdt_ioctl(struct file *file, unsigned int cmd,
>  		if (cpu_is_omap16xx())
>  			return put_user(__raw_readw(ARM_SYSST),
>  					(int __user *)arg);
> -		if (cpu_is_omap24xx())
> +		if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx())
>  			return put_user(omap_prcm_get_reset_sources(),
>  					(int __user *)arg);
>  		return put_user(0, (int __user *)arg);
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
