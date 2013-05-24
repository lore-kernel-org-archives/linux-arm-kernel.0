From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 24 May 2013 10:51:50 +0200
Subject: [PATCH] at91: sama5: fix incorrect PMC pcr div definition
In-Reply-To: <1369304328-11442-1-git-send-email-josh.wu@atmel.com>
References: <1369304328-11442-1-git-send-email-josh.wu@atmel.com>
Message-ID: <519F2A26.3080907@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/05/2013 12:18, Josh Wu :
>
> Signed-off-by: Josh Wu <josh.wu@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

And stacked on top of at91-3.10-fixes.

Thanks for catching this! Bye.

> ---
>   arch/arm/mach-at91/include/mach/at91_pmc.h |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-at91/include/mach/at91_pmc.h b/arch/arm/mach-at91/include/mach/at91_pmc.h
> index 31df120..2bd7f51 100644
> --- a/arch/arm/mach-at91/include/mach/at91_pmc.h
> +++ b/arch/arm/mach-at91/include/mach/at91_pmc.h
> @@ -179,9 +179,9 @@ extern void __iomem *at91_pmc_base;
>   #define		AT91_PMC_PCR_CMD	(0x1  <<  12)		/* Command (read=0, write=1) */
>   #define		AT91_PMC_PCR_DIV(n)	((n)  <<  16)		/* Divisor Value */
>   #define			AT91_PMC_PCR_DIV0	0x0			/* Peripheral clock is MCK */
> -#define			AT91_PMC_PCR_DIV2	0x2			/* Peripheral clock is MCK/2 */
> -#define			AT91_PMC_PCR_DIV4	0x4			/* Peripheral clock is MCK/4 */
> -#define			AT91_PMC_PCR_DIV8	0x8			/* Peripheral clock is MCK/8 */
> +#define			AT91_PMC_PCR_DIV2	0x1			/* Peripheral clock is MCK/2 */
> +#define			AT91_PMC_PCR_DIV4	0x2			/* Peripheral clock is MCK/4 */
> +#define			AT91_PMC_PCR_DIV8	0x3			/* Peripheral clock is MCK/8 */
>   #define		AT91_PMC_PCR_EN		(0x1  <<  28)		/* Enable */
>
>   #endif
>


-- 
Nicolas Ferre
