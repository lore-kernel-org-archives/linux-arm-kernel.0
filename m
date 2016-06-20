From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 20 Jun 2016 09:47:25 +0200
Subject: [PATCH] ARM: at91: fix warnings in pm.c
In-Reply-To: <1466177658-26179-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466177658-26179-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <57679F8D.5000406@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 17/06/2016 17:34, Ben Dooks a ?crit :
> Fix a pair of missing statics on un-exported functions and
> include <linux/platform_data/atmel.h> to provide the declaration
> of at91_suspend_entering_slow_clock() to fix the following
> sparse warnings:
> 
> arch/arm/mach-at91/pm.c:127:5: warning: symbol 'at91_suspend_entering_slow_clock' was not declared. Should it be static?
> arch/arm/mach-at91/pm.c:358:6: warning: symbol 'at91rm9200_idle' was not declared. Should it be static?
> arch/arm/mach-at91/pm.c:367:6: warning: symbol 'at91sam9_idle' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks Ben!

Bye,

> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm/mach-at91/pm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index f062701..b4332b7 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -22,6 +22,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/of_address.h>
>  #include <linux/platform_device.h>
> +#include <linux/platform_data/atmel.h>
>  #include <linux/io.h>
>  #include <linux/clk/at91_pmc.h>
>  
> @@ -355,7 +356,7 @@ static __init void at91_dt_ramc(void)
>  	at91_pm_set_standby(standby);
>  }
>  
> -void at91rm9200_idle(void)
> +static void at91rm9200_idle(void)
>  {
>  	/*
>  	 * Disable the processor clock.  The processor will be automatically
> @@ -364,7 +365,7 @@ void at91rm9200_idle(void)
>  	writel(AT91_PMC_PCK, pmc + AT91_PMC_SCDR);
>  }
>  
> -void at91sam9_idle(void)
> +static void at91sam9_idle(void)
>  {
>  	writel(AT91_PMC_PCK, pmc + AT91_PMC_SCDR);
>  	cpu_do_idle();
> 


-- 
Nicolas Ferre
