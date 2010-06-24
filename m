From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 24 Jun 2010 21:57:00 +0900
Subject: [PATCH 2/2] ARM: S5PV210: Fix GONI board UART FIFO mode
	configration
In-Reply-To: <1277354105-13097-2-git-send-email-jy0922.shim@samsung.com>
References: <1277354105-13097-1-git-send-email-jy0922.shim@samsung.com>
	<1277354105-13097-2-git-send-email-jy0922.shim@samsung.com>
Message-ID: <012d01cb139c$bf01c020$3d054060$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joonyoung Shim wrote:
> 
> The GONI board uses max UART FIFO size to each UART channels.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv210/mach-goni.c |   16 +++++++++-------
>  1 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/mach-goni.c
b/arch/arm/mach-s5pv210/mach-
> goni.c
> index 4863b13..0cfb8db 100644
> --- a/arch/arm/mach-s5pv210/mach-goni.c
> +++ b/arch/arm/mach-s5pv210/mach-goni.c
> @@ -36,9 +36,7 @@
> 
>  #define S5PV210_ULCON_DEFAULT	S3C2410_LCON_CS8
> 
> -#define S5PV210_UFCON_DEFAULT	(S3C2410_UFCON_FIFOMODE |	\
> -				 S5PV210_UFCON_TXTRIG4 |	\
> -				 S5PV210_UFCON_RXTRIG4)
> +#define S5PV210_UFCON_DEFAULT	S3C2410_UFCON_FIFOMODE
> 
>  static struct s3c2410_uartcfg goni_uartcfgs[] __initdata = {
>  	[0] = {
> @@ -46,28 +44,32 @@ static struct s3c2410_uartcfg goni_uartcfgs[]
__initdata = {
>  		.flags		= 0,
>  		.ucon		= S5PV210_UCON_DEFAULT,
>  		.ulcon		= S5PV210_ULCON_DEFAULT,
> -		.ufcon		= S5PV210_UFCON_DEFAULT,
> +		.ufcon		= S5PV210_UFCON_DEFAULT |
> +			S5PV210_UFCON_TXTRIG256 |
> S5PV210_UFCON_RXTRIG256,
>  	},
>  	[1] = {
>  		.hwport		= 1,
>  		.flags		= 0,
>  		.ucon		= S5PV210_UCON_DEFAULT,
>  		.ulcon		= S5PV210_ULCON_DEFAULT,
> -		.ufcon		= S5PV210_UFCON_DEFAULT,
> +		.ufcon		= S5PV210_UFCON_DEFAULT |
> +			S5PV210_UFCON_TXTRIG64 |
> S5PV210_UFCON_RXTRIG64,
>  	},
>  	[2] = {
>  		.hwport		= 2,
>  		.flags		= 0,
>  		.ucon		= S5PV210_UCON_DEFAULT,
>  		.ulcon		= S5PV210_ULCON_DEFAULT,
> -		.ufcon		= S5PV210_UFCON_DEFAULT,
> +		.ufcon		= S5PV210_UFCON_DEFAULT |
> +			S5PV210_UFCON_TXTRIG16 |
> S5PV210_UFCON_RXTRIG16,
>  	},
>  	[3] = {
>  		.hwport		= 3,
>  		.flags		= 0,
>  		.ucon		= S5PV210_UCON_DEFAULT,
>  		.ulcon		= S5PV210_ULCON_DEFAULT,
> -		.ufcon		= S5PV210_UFCON_DEFAULT,
> +		.ufcon		= S5PV210_UFCON_DEFAULT |
> +			S5PV210_UFCON_TXTRIG16 |
> S5PV210_UFCON_RXTRIG16,
>  	},
>  };
> 
> --

OK..will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
