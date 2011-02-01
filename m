From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 1 Feb 2011 19:18:45 +0100
Subject: [PATCH] ARM: pxa: Properly configure PWM period for palm27x
In-Reply-To: <1296511613-24406-1-git-send-email-marek.vasut@gmail.com>
References: <1296511613-24406-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <201102011918.45662.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 31 January 2011 23:06:53 Marek Vasut wrote:
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
>  arch/arm/mach-pxa/palm27x.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
> index 7d1434a..4c9a938 100644
> --- a/arch/arm/mach-pxa/palm27x.c
> +++ b/arch/arm/mach-pxa/palm27x.c
> @@ -322,7 +322,7 @@ static struct platform_pwm_backlight_data
> palm27x_backlight_data = { .pwm_id		= 0,
>  	.max_brightness	= 0xfe,
>  	.dft_brightness	= 0x7e,
> -	.pwm_period_ns	= 3500,
> +	.pwm_period_ns	= 3500 * 1024,
>  	.init		= palm27x_backlight_init,
>  	.notify		= palm27x_backlight_notify,
>  	.exit		= palm27x_backlight_exit,

CC linux-arm-kernel, I mistyped, sorry
