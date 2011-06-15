From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 15 Jun 2011 15:29:43 +0200
Subject: [PATCH] mach-ixp4xx: fix build error
In-Reply-To: <1308127390-30563-1-git-send-email-linus.walleij@stericsson.com>
References: <1308127390-30563-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110615132943.GA14917@riccoc20.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2011 at 10:43:10AM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The introduction of clocksource_mmio_init() broke ixp4xx due to
> a surplus ampersand - IXP4XX_OSTS is already a pointe to I/O
> space.

The fix you suggest will not work on big endian ixp. See

   http://lists.arm.linux.org.uk/lurker/message/20110530.084307.f960f906.en.html

Thanks,
Richard


> 
> Cc: Deepak Saxena <deepak.saxena@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-ixp4xx/common.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
> index 74ed81a..5ec2918 100644
> --- a/arch/arm/mach-ixp4xx/common.c
> +++ b/arch/arm/mach-ixp4xx/common.c
> @@ -425,7 +425,7 @@ static void __init ixp4xx_clocksource_init(void)
>  {
>  	init_sched_clock(&cd, ixp4xx_update_sched_clock, 32, ixp4xx_timer_freq);
>  
> -	clocksource_mmio_init(&IXP4XX_OSTS, "OSTS", ixp4xx_timer_freq, 200, 32,
> +	clocksource_mmio_init(IXP4XX_OSTS, "OSTS", ixp4xx_timer_freq, 200, 32,
>  			clocksource_mmio_readl_up);
>  }
>  
> -- 
> 1.7.3.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
