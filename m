From: stigge@antcom.de (Roland Stigge)
Date: Mon, 10 Feb 2014 10:49:08 +0100
Subject: [PATCH 2/7] ARM: lpc32xx: don't select HAVE_PWM
In-Reply-To: <003b01cf25fc$bd4b51d0$37e1f570$%han@samsung.com>
References: <003901cf25fc$73002790$590076b0$%han@samsung.com>
 <003b01cf25fc$bd4b51d0$37e1f570$%han@samsung.com>
Message-ID: <52F8A094.2000608@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/14 02:09, Jingoo Han wrote:
> The HAVE_PWM symbol is only for legacy platforms that provide
> the PWM API without using the generic framework. The lpc32xx
> platforms use the generic PWM framework, after the commit "2132fa8
> pwm: add lpc32xx PWM support".
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  arch/arm/Kconfig |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e254198..897fa15 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -632,7 +632,6 @@ config ARCH_LPC32XX
>  	select CPU_ARM926T
>  	select GENERIC_CLOCKEVENTS
>  	select HAVE_IDE
> -	select HAVE_PWM
>  	select USB_ARCH_HAS_OHCI
>  	select USE_OF
>  	help
> 

Acked-by: Roland Stigge <stigge@antcom.de>
