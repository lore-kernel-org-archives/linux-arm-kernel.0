From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 11 Mar 2015 17:52:31 +0100
Subject: [PATCH] pm: at91: pm_slowclock: fix the compilation error
In-Reply-To: <1426039692-30005-1-git-send-email-wenyou.yang@atmel.com>
References: <1426039692-30005-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <550072CF.3080303@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 11/03/2015 03:08, Wenyou Yang a ?crit :
> When compiling the kernel in thumb2 (CONFIG_THUMB2_KERNEL option activated), we
> hit a compilation error. The error message is listed below:
> 
> ---8< -----
> Error: cannot use register index with PC-relative addressing -- `str r0,.saved_lpr'
> --->8----
> 
> Add the .arm directive in the assembly files related to power management.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Stacked on at91-4.0-fixes. Thanks.

> ---
>  arch/arm/mach-at91/pm_slowclock.S |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-at91/pm_slowclock.S b/arch/arm/mach-at91/pm_slowclock.S
> index 8ab80e5..931f0e3 100644
> --- a/arch/arm/mach-at91/pm_slowclock.S
> +++ b/arch/arm/mach-at91/pm_slowclock.S
> @@ -70,6 +70,8 @@ tmp2	.req	r5
>  
>  	.text
>  
> +	.arm
> +
>  /* void at91_slow_clock(void __iomem *pmc, void __iomem *sdramc,
>   *			void __iomem *ramc1, int memctrl)
>   */
> 


-- 
Nicolas Ferre
