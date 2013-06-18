From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 18 Jun 2013 08:42:36 -0700
Subject: [PATCH V3 01/14] watchdog/mpcore_wdt: Mark it as BROKEN
In-Reply-To: <22d22fe6eea294c5132e47b8901e094d60b0e99d.1371535242.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
 <22d22fe6eea294c5132e47b8901e094d60b0e99d.1371535242.git.viresh.kumar@linaro.org>
Message-ID: <20130618154236.GA9022@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 08:50:25PM +0530, Viresh Kumar wrote:
> This driver was broken since ever.
> 
> - Interrupt request doesn't use the right API: The TWD watchdog uses a per-cpu
>   interrupt (usually interrupt #30), and the GIC configuration should flag it as
>   such. With this setup, request_irq() should fail, and the right API is
>   request_percpu_irq(), together with enable_percpu_irq()/disable_percpu_irq().
> 
> - Nothing ensures the userspace ioctl() will end-up kicking the watchdog on the
>   right CPU.
> 
> Was last discussed here:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-April/095960.html
> 
> Lets mark it broken until somebody with this hardware gets up and fixes it.
> 
I must be missing something. What is the point of the remaining patches in this
case ?

Guenter

> Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 9d03af1..c7dabe9 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -223,7 +223,7 @@ config DW_WATCHDOG
>  
>  config MPCORE_WATCHDOG
>  	tristate "MPcore watchdog"
> -	depends on HAVE_ARM_TWD
> +	depends on HAVE_ARM_TWD && BROKEN
>  	help
>  	  Watchdog timer embedded into the MPcore system.
>  
> -- 
> 1.7.12.rc2.18.g61b472e
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
