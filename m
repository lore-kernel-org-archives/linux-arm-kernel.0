From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 18 Mar 2016 11:34:28 +0100
Subject: [PATCH 2/3] ARM: at91/soc: reference the whole sama5d2 family
In-Reply-To: <1458285681-25684-2-git-send-email-ludovic.desroches@atmel.com>
References: <1458285681-25684-1-git-send-email-ludovic.desroches@atmel.com>
 <1458285681-25684-2-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20160318103428.GB2531@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/03/2016 at 08:21:20 +0100, Ludovic Desroches wrote :
> Add EXID of all SoCs of the SAMA5D2 family.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  arch/arm/mach-at91/sama5.c | 20 +++++++++++++++++++-
>  arch/arm/mach-at91/soc.h   | 12 +++++++++++-
>  2 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
> index df8fdf1..922b85f 100644
> --- a/arch/arm/mach-at91/sama5.c
> +++ b/arch/arm/mach-at91/sama5.c
> @@ -18,8 +18,26 @@
>  #include "soc.h"
>  
>  static const struct at91_soc sama5_socs[] = {
> -	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D27_EXID_MATCH,
> +	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D21CU_EXID_MATCH,
> +		 "sama5d21", "sama5d2"),
> +	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D22CU_EXID_MATCH,
> +		 "sama5d22", "sama5d2"),
> +	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D23CU_EXID_MATCH,
> +		 "sama5d23", "sama5d2"),
> +	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D24CX_EXID_MATCH,
> +		 "sama5d24", "sama5d2"),
> +	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D24CU_EXID_MATCH,
> +		 "sama5d24", "sama5d2"),
> +	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D26CU_EXID_MATCH,
> +		 "sama5d26", "sama5d2"),
> +	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D27CU_EXID_MATCH,
>  		 "sama5d27", "sama5d2"),
> +	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D27CN_EXID_MATCH,
> +		 "sama5d27", "sama5d2"),
> +	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D28CU_EXID_MATCH,
> +		 "sama5d28", "sama5d2"),
> +	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D28CN_EXID_MATCH,
> +		 "sama5d28", "sama5d2"),
>  	AT91_SOC(SAMA5D3_CIDR_MATCH, SAMA5D31_EXID_MATCH,
>  		 "sama5d31", "sama5d3"),
>  	AT91_SOC(SAMA5D3_CIDR_MATCH, SAMA5D33_EXID_MATCH,
> diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
> index 8ede0ef..228efde 100644
> --- a/arch/arm/mach-at91/soc.h
> +++ b/arch/arm/mach-at91/soc.h
> @@ -63,7 +63,17 @@ at91_soc_init(const struct at91_soc *socs);
>  #define AT91SAM9XE512_CIDR_MATCH	0x329aa3a0
>  
>  #define SAMA5D2_CIDR_MATCH		0x0a5c08c0
> -#define SAMA5D27_EXID_MATCH		0x00000021
> +#define SAMA5D21CU_EXID_MATCH		0x0000005a
> +#define SAMA5D22CU_EXID_MATCH		0x00000059
> +#define SAMA5D22CN_EXID_MATCH		0x00000069
> +#define SAMA5D23CU_EXID_MATCH		0x00000058
> +#define SAMA5D24CX_EXID_MATCH		0x00000004
> +#define SAMA5D24CU_EXID_MATCH		0x00000014
> +#define SAMA5D26CU_EXID_MATCH		0x00000012
> +#define SAMA5D27CU_EXID_MATCH		0x00000011
> +#define SAMA5D27CN_EXID_MATCH		0x00000021
> +#define SAMA5D28CU_EXID_MATCH		0x00000010
> +#define SAMA5D28CN_EXID_MATCH		0x00000020
>  
>  #define SAMA5D3_CIDR_MATCH		0x0a5c07c0
>  #define SAMA5D31_EXID_MATCH		0x00444300
> -- 
> 2.5.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
