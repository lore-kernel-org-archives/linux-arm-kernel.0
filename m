From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 21 May 2013 11:06:58 +0200
Subject: [PATCH] ARM: at91: Fix: Change internal SRAM memory type to
 "MT_MEMORY_SO"
In-Reply-To: <1369011979-21354-1-git-send-email-wenyou.yang@atmel.com>
References: <1369011911-21282-1-git-send-email-wenyou.yang@atmel.com>
 <1369011979-21354-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <519B3932.7030508@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/05/2013 03:06, Wenyou Yang :
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

And stacked on at91-3.10-fixes.

Best regards,

> ---
>   arch/arm/mach-at91/setup.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
> index e2f4bdd..d68be6c 100644
> --- a/arch/arm/mach-at91/setup.c
> +++ b/arch/arm/mach-at91/setup.c
> @@ -80,7 +80,7 @@ void __init at91_init_sram(int bank, unsigned long base, unsigned int length)
>
>   	desc->pfn = __phys_to_pfn(base);
>   	desc->length = length;
> -	desc->type = MT_DEVICE;
> +	desc->type = MT_MEMORY_SO;
>
>   	pr_info("AT91: sram at 0x%lx of 0x%x mapped at 0x%lx\n",
>   		base, length, desc->virtual);
>


-- 
Nicolas Ferre
