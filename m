From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 03 Jul 2017 14:51:19 +0200
Subject: [PATCH 2/8] ARM: aurora-l2: add prefix to MAX_RANGE_SIZE
In-Reply-To: <20170630145106.29820-3-jlu@pengutronix.de> (Jan Luebbe's message
 of "Fri, 30 Jun 2017 16:51:00 +0200")
References: <20170630145106.29820-1-jlu@pengutronix.de>
 <20170630145106.29820-3-jlu@pengutronix.de>
Message-ID: <87k23pvg3c.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jan,
 
 On ven., juin 30 2017, Jan Luebbe <jlu@pengutronix.de> wrote:

> The macro name is too generic, so add a AURORA_ prefix.
>
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>

Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory

> ---
>  arch/arm/include/asm/hardware/cache-aurora-l2.h | 2 +-
>  arch/arm/mm/cache-l2x0.c                        | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/include/asm/hardware/cache-aurora-l2.h b/arch/arm/include/asm/hardware/cache-aurora-l2.h
> index c86124769831..dc5c479ec4c3 100644
> --- a/arch/arm/include/asm/hardware/cache-aurora-l2.h
> +++ b/arch/arm/include/asm/hardware/cache-aurora-l2.h
> @@ -41,7 +41,7 @@
>  #define AURORA_ACR_FORCE_WRITE_THRO_POLICY	\
>  	(2 << AURORA_ACR_FORCE_WRITE_POLICY_OFFSET)
>  
> -#define MAX_RANGE_SIZE		1024
> +#define AURORA_MAX_RANGE_SIZE	1024
>  
>  #define AURORA_WAY_SIZE_SHIFT	2
>  
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index a00d6f7fd34c..7d2d2a3c67d0 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -1364,8 +1364,8 @@ static unsigned long aurora_range_end(unsigned long start, unsigned long end)
>  	 * since cache range operations stall the CPU pipeline
>  	 * until completion.
>  	 */
> -	if (end > start + MAX_RANGE_SIZE)
> -		end = start + MAX_RANGE_SIZE;
> +	if (end > start + AURORA_MAX_RANGE_SIZE)
> +		end = start + AURORA_MAX_RANGE_SIZE;
>  
>  	/*
>  	 * Cache range operations can't straddle a page boundary.
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
