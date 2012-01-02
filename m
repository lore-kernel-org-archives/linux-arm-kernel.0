From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 02 Jan 2012 15:21:48 +0100
Subject: [PATCH] at91: fix at91rm9200 soc subtype handling
In-Reply-To: <1325070604-5560-1-git-send-email-veli-pekka.peltola@bluegiga.com>
References: <1325070604-5560-1-git-send-email-veli-pekka.peltola@bluegiga.com>
Message-ID: <4F01BD7C.6000902@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/28/2011 12:10 PM, Veli-Pekka Peltola :
> BGA should be the default SoC subtype but it is set to unknown if
> not explicitly set to PQFP. Currently setting it to PQFP sets subtype
> to BGA as subtypes are swapped in at91rm9200_set_type().
> 
> Wrong subtype causes GPIO bank D not to work at all.
> 
> After this fix BGA subtype is set as default. On boot BGA is printed
> always but it is set to PQFP if requested before setting amount of GPIO
> banks.
> 
> Signed-off-by: Veli-Pekka Peltola <veli-pekka.peltola@bluegiga.com>

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I will queue it in a "fixes" branch (hopefully for 3.3).

thanks a lot. Best regards,


> ---
>  arch/arm/mach-at91/setup.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
> index aa64294..e6b07ad 100644
> --- a/arch/arm/mach-at91/setup.c
> +++ b/arch/arm/mach-at91/setup.c
> @@ -27,9 +27,9 @@ EXPORT_SYMBOL(at91_soc_initdata);
>  void __init at91rm9200_set_type(int type)
>  {
>  	if (type == ARCH_REVISON_9200_PQFP)
> -		at91_soc_initdata.subtype = AT91_SOC_RM9200_BGA;
> -	else
>  		at91_soc_initdata.subtype = AT91_SOC_RM9200_PQFP;
> +	else
> +		at91_soc_initdata.subtype = AT91_SOC_RM9200_BGA;
>  }
>  
>  void __init at91_init_irq_default(void)
> @@ -118,6 +118,7 @@ static void __init soc_detect(u32 dbgu_base)
>  
>  	case ARCH_ID_AT91RM9200:
>  		at91_soc_initdata.type = AT91_SOC_RM9200;
> +		at91_soc_initdata.subtype = AT91_SOC_RM9200_BGA;
>  		at91_boot_soc = at91rm9200_soc;
>  		break;
>  


-- 
Nicolas Ferre
