From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 06 Apr 2012 14:56:45 +0200
Subject: [PATCH] ARM: at91: Export at91_ramc_base
In-Reply-To: <4f761fd8.8843cc0a.22b0.6caa@mx.google.com>
References: <4f761fd8.8843cc0a.22b0.6caa@mx.google.com>
Message-ID: <4F7EE80D.1000905@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/30/2012 11:03 PM, manabian at gmail.com :
> From: Joachim Eastwood <joachim.eastwood@jotron.com>
> 
> After commit f363c407b42c4 building at91_cf as a module fails with:
>   ERROR: "at91_ramc_base" [drivers/pcmcia/at91_cf.ko] undefined!
>   make[1]: *** [__modpost] Error 1
>   make: *** [modules] Error 2
> 
> Export at91_ramc_base symbol to allow drivers using at91_ramc_*
> functions to be built as modules again.
> 
> Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

and queued in at91-fixes for 3.4

(I modified commit message in relation with Sergei's comment).

Thanks, best regards,


> ---
> 
> This makes at91_cf compile again but it still doesn't work. Still
> trying to figure out why.
> 
>  arch/arm/mach-at91/setup.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
> index 1083739..aa010a9 100644
> --- a/arch/arm/mach-at91/setup.c
> +++ b/arch/arm/mach-at91/setup.c
> @@ -53,6 +53,7 @@ void __init at91_init_interrupts(unsigned int *priority)
>  }
>  
>  void __iomem *at91_ramc_base[2];
> +EXPORT_SYMBOL(at91_ramc_base);
>  
>  void __init at91_ioremap_ramc(int id, u32 addr, u32 size)
>  {


-- 
Nicolas Ferre
