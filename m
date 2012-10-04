From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 04 Oct 2012 17:00:23 +0200
Subject: [PATCH] pwm: Get rid of HAVE_PWM
In-Reply-To: <1349330819-11924-1-git-send-email-thierry.reding@avionic-design.de>
References: <1349330819-11924-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <506DA487.9070400@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/2012 08:06 AM, Thierry Reding wrote:
> [...]
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 331d574..b38f23d 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -219,7 +219,8 @@ config MACH_JZ4740
>  	select GENERIC_GPIO
>  	select ARCH_REQUIRE_GPIOLIB
>  	select SYS_HAS_EARLY_PRINTK
> -	select HAVE_PWM
> +	select PWM
> +	select PWM_JZ4740
>  	select HAVE_CLK
>  	select GENERIC_IRQ_CHIP

I'm not sure if this is such a good idea, not all jz4740 based board
necessarily require PWM.

- Lars
