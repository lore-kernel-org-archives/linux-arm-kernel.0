From: csd@broadcom.com (Christian Daudt)
Date: Fri, 26 Apr 2013 08:41:55 -0700
Subject: [PATCH] ARM: bcm: mark bcm_kona_smc_init as __init
In-Reply-To: <201304231744.40614.arnd@arndb.de>
References: <201304231744.40614.arnd@arndb.de>
Message-ID: <517AA043.30005@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-04-23 08:44 AM, Arnd Bergmann wrote:
> The bcm_kona_smc_init function references the bcm_kona_smc_ids variable
> that is marked __initconst, so the function itself has to be __init
> to avoid this build error:
>
> WARNING: arch/arm/mach-bcm/built-in.o(.text+0x12c): Section mismatch in reference from the function bcm_kona_smc_init() to the (unknown reference) .init.rodata:(unknown)
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Christian Daudt <csd@broadcom.com>
> ---
> I have applied this trivial fix to the next/firmware branch
>
> diff --git a/arch/arm/mach-bcm/bcm_kona_smc.c b/arch/arm/mach-bcm/bcm_kona_smc.c
> index 5f1d131..56d9d19 100644
> --- a/arch/arm/mach-bcm/bcm_kona_smc.c
> +++ b/arch/arm/mach-bcm/bcm_kona_smc.c
> @@ -41,7 +41,7 @@ static const struct of_device_id bcm_kona_smc_ids[] __initconst = {
>   };
>   
>   /* Map in the bounce area */
> -void bcm_kona_smc_init(void)
> +void __init bcm_kona_smc_init(void)
>   {
>   	struct device_node *node;
>   
>
acked-by: Christian Daudt <csd@broadcom.com>
