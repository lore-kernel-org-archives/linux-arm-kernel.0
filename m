From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 4 Dec 2010 16:10:17 +0100
Subject: [PATCH] arm/income pxa270: enable backlight when pwm_bl is a
	module
In-Reply-To: <20101204152923.04244dfa@absol.kitzblitz>
References: <20101204152923.04244dfa@absol.kitzblitz>
Message-ID: <201012041610.17342.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 04 December 2010 15:29:23 Nicolas Kaiser wrote:
> Fixes a suspected typo in the config symbol.
> 
> Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
> ---
> I don't have the hardware to test, but this config symbol looks
> unusual enough to me that I'm suspecting it might be a typo.
> 
>  arch/arm/mach-pxa/colibri-pxa270-income.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/colibri-pxa270-income.c
> b/arch/arm/mach-pxa/colibri-pxa270-income.c index 37f0f3e..3aba0e1 100644
> --- a/arch/arm/mach-pxa/colibri-pxa270-income.c
> +++ b/arch/arm/mach-pxa/colibri-pxa270-income.c
> @@ -231,7 +231,7 @@ static inline void income_lcd_init(void) {}
>  /*************************************************************************
> ***** * Backlight
>  
> **************************************************************************
> ****/ -#if defined(CONFIG_BACKLIGHT_PWM) ||
> defined(CONFIG_BACKLIGHT_PWM__MODULE) +#if defined(CONFIG_BACKLIGHT_PWM)
> || defined(CONFIG_BACKLIGHT_PWM_MODULE) static struct
> platform_pwm_backlight_data income_backlight_data = { .pwm_id		= 0,
>  	.max_brightness	= 0x3ff,

Acked-by: Marek Vasut <marek.vasut@gmail.com>

Cheers
