From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 3 Mar 2015 20:05:56 +0100
Subject: [PATCH] ARM: at91: pm: fix at91rm9200 standby
In-Reply-To: <1425409102-29337-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1425409102-29337-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <54F60614.8070307@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 03/03/2015 19:58, Alexandre Belloni a ?crit :
> at91rm9200 standby and suspend to ram has been broken since
> 00482a4078f4. It is wrongly using AT91_BASE_SYS which is a physical address
> and actually doesn't correspond to any register on at91rm9200.
> 
> Use the correct at91_ramc_base[0] instead.
> 
> Fixes: 00482a4078f4 (ARM: at91: implement the standby function for pm/cpuidle)
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
and immediately added to at91-4.0-fixes.

Thanks. Bye,

> ---
>  arch/arm/mach-at91/pm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
> index d2c89963af2d..86c0aa819d25 100644
> --- a/arch/arm/mach-at91/pm.h
> +++ b/arch/arm/mach-at91/pm.h
> @@ -44,7 +44,7 @@ static inline void at91rm9200_standby(void)
>  		"    mcr    p15, 0, %0, c7, c0, 4\n\t"
>  		"    str    %5, [%1, %2]"
>  		:
> -		: "r" (0), "r" (AT91_BASE_SYS), "r" (AT91RM9200_SDRAMC_LPR),
> +		: "r" (0), "r" (at91_ramc_base[0]), "r" (AT91RM9200_SDRAMC_LPR),
>  		  "r" (1), "r" (AT91RM9200_SDRAMC_SRR),
>  		  "r" (lpr));
>  }
> 


-- 
Nicolas Ferre
