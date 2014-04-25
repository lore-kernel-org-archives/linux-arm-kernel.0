From: mporter@linaro.org (Matt Porter)
Date: Fri, 25 Apr 2014 09:58:24 -0400
Subject: [PATCH V2] ARM: mach-bcm: add ARM_ERRATA_775420
In-Reply-To: <1397841200-14061-1-git-send-email-sbranden@broadcom.com>
References: <1397841200-14061-1-git-send-email-sbranden@broadcom.com>
Message-ID: <20140425135824.GG1127@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 18, 2014 at 10:13:20AM -0700, Scott Branden wrote:
> ARM_ERRATA_775420 needs to be enabled.
> 
> A data cache maintenance operation which aborts, followed by an ISB,
> without any DSB in-between, might lead to deadlock.
> 
> Affects: bug present in Cortex-A9 r3p0 and earlier. Fixed in r4p0.
> 
> Cortex-A9 r3p0 is used in a multitude of Broadcom parts including
> the bcm21664, bcm281xx, 5301x families of devices.

Applied to mach-bcm for-3.16/soc

Thanks,
Matt

> Signed-off-by: Scott Branden <sbranden@broadcom.com>
> Tested-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Alex Elder <elder@linaro.org>
> Acked-by: Matt Porter <mporter@linaro.org>
> ---
>  arch/arm/mach-bcm/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index 49c914c..9ef7f65 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -15,6 +15,7 @@ config ARCH_BCM_MOBILE
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARM_ERRATA_754322
>  	select ARM_ERRATA_764369 if SMP
> +	select ARM_ERRATA_775420
>  	select ARM_GIC
>  	select GPIO_BCM_KONA
>  	select TICK_ONESHOT
> -- 
> 1.7.9.5
> 
