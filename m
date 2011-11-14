From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 14 Nov 2011 15:52:19 +0100
Subject: [PATCH 08/12] ARM: at91: make CCFG soc independent
In-Reply-To: <1321207952-13556-8-git-send-email-plagnioj@jcrosoft.com>
References: <20111113180954.GD15318@game.jcrosoft.org>
 <1321207952-13556-8-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <4EC12B23.4080809@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maybe we can rid of this value...


On 11/13/2011 07:12 PM, Jean-Christophe PLAGNIOL-VILLARD :
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  arch/arm/mach-at91/include/mach/at91cap9.h    |    2 +-
>  arch/arm/mach-at91/include/mach/at91sam9260.h |    2 +-
>  arch/arm/mach-at91/include/mach/at91sam9263.h |    2 +-
>  arch/arm/mach-at91/include/mach/at91sam9rl.h  |    2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/include/mach/at91cap9.h b/arch/arm/mach-at91/include/mach/at91cap9.h
> index d7d0b68..cf8cd56 100644
> --- a/arch/arm/mach-at91/include/mach/at91cap9.h
> +++ b/arch/arm/mach-at91/include/mach/at91cap9.h
> @@ -82,7 +82,6 @@
>  #define AT91_BCRAMC	(0xffffe400 - AT91_BASE_SYS)
>  #define AT91_DDRSDRC0	(0xffffe600 - AT91_BASE_SYS)
>  #define AT91_MATRIX	(0xffffea00 - AT91_BASE_SYS)
> -#define AT91_CCFG	(0xffffeb10 - AT91_BASE_SYS)
>  #define AT91_DBGU	(0xffffee00 - AT91_BASE_SYS)
>  #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
>  #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
> @@ -96,6 +95,7 @@
>  #define AT91CAP9_BASE_ECC	0xffffe200
>  #define AT91CAP9_BASE_DMA	0xffffec00
>  #define AT91CAP9_BASE_SMC	0xffffe800
> +#define AT91CAP9_BASE_CCFG	0xffffeb10
>  #define AT91CAP9_BASE_PIOA	0xfffff200
>  #define AT91CAP9_BASE_PIOB	0xfffff400
>  #define AT91CAP9_BASE_PIOC	0xfffff600
> diff --git a/arch/arm/mach-at91/include/mach/at91sam9260.h b/arch/arm/mach-at91/include/mach/at91sam9260.h
> index e55ab6a..930a7a8 100644
> --- a/arch/arm/mach-at91/include/mach/at91sam9260.h
> +++ b/arch/arm/mach-at91/include/mach/at91sam9260.h
> @@ -82,7 +82,6 @@
>   */
>  #define AT91_SDRAMC0	(0xffffea00 - AT91_BASE_SYS)
>  #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
> -#define AT91_CCFG	(0xffffef10 - AT91_BASE_SYS)
>  #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
>  #define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
>  #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
> @@ -93,6 +92,7 @@
>  
>  #define AT91SAM9260_BASE_ECC	0xffffe800
>  #define AT91SAM9260_BASE_SMC	0xffffec00
> +#define AT91SAM9260_BASE_CCFG	0xffffef10
>  #define AT91SAM9260_BASE_PIOA	0xfffff400
>  #define AT91SAM9260_BASE_PIOB	0xfffff600
>  #define AT91SAM9260_BASE_PIOC	0xfffff800
> diff --git a/arch/arm/mach-at91/include/mach/at91sam9263.h b/arch/arm/mach-at91/include/mach/at91sam9263.h
> index b827ff7..5b6b2b1 100644
> --- a/arch/arm/mach-at91/include/mach/at91sam9263.h
> +++ b/arch/arm/mach-at91/include/mach/at91sam9263.h
> @@ -77,7 +77,6 @@
>  #define AT91_SDRAMC0	(0xffffe200 - AT91_BASE_SYS)
>  #define AT91_SDRAMC1	(0xffffe800 - AT91_BASE_SYS)
>  #define AT91_MATRIX	(0xffffec00 - AT91_BASE_SYS)
> -#define AT91_CCFG	(0xffffed10 - AT91_BASE_SYS)
>  #define AT91_DBGU	(0xffffee00 - AT91_BASE_SYS)
>  #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
>  #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
> @@ -90,6 +89,7 @@
>  #define AT91SAM9263_BASE_SMC0	0xffffe400
>  #define AT91SAM9263_BASE_ECC1	0xffffe600
>  #define AT91SAM9263_BASE_SMC1	0xffffea00
> +#define AT91SAM9263_BASE_CCFG	0xffffed10
>  #define AT91SAM9263_BASE_PIOA	0xfffff200
>  #define AT91SAM9263_BASE_PIOB	0xfffff400
>  #define AT91SAM9263_BASE_PIOC	0xfffff600
> diff --git a/arch/arm/mach-at91/include/mach/at91sam9rl.h b/arch/arm/mach-at91/include/mach/at91sam9rl.h
> index 846139d..c94e691 100644
> --- a/arch/arm/mach-at91/include/mach/at91sam9rl.h
> +++ b/arch/arm/mach-at91/include/mach/at91sam9rl.h
> @@ -71,7 +71,6 @@
>   */
>  #define AT91_SDRAMC0	(0xffffea00 - AT91_BASE_SYS)
>  #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
> -#define AT91_CCFG	(0xffffef10 - AT91_BASE_SYS)
>  #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
>  #define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
>  #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
> @@ -85,6 +84,7 @@
>  #define AT91SAM9RL_BASE_DMA	0xffffe600
>  #define AT91SAM9RL_BASE_ECC	0xffffe800
>  #define AT91SAM9RL_BASE_SMC	0xffffec00
> +#define AT91SAM9RL_BASE_CCFG	0xffffef10
>  #define AT91SAM9RL_BASE_PIOA	0xfffff400
>  #define AT91SAM9RL_BASE_PIOB	0xfffff600
>  #define AT91SAM9RL_BASE_PIOC	0xfffff800


-- 
Nicolas Ferre
