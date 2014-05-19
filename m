From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 May 2014 13:50:33 -0700
Subject: [PATCHv2 resend 07/11] ARM: OMAP3: Beagle: use PWM_LOOKUP to
 initialize struct pwm_lookup
In-Reply-To: <1400532162-29483-8-git-send-email-alexandre.belloni@free-electrons.com>
References: <1400532162-29483-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1400532162-29483-8-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140519205033.GE11945@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Alexandre Belloni <alexandre.belloni@free-electrons.com> [140519 13:44]:

Missing description?

Presumably you'll fix that so:

Acked-by: Tony Lindgren <tony@atomide.com>

> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/mach-omap2/board-omap3beagle.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index f27e1ec90b5e..54c135a5b4f7 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -61,14 +61,8 @@
>  
>  static struct pwm_lookup pwm_lookup[] = {
>  	/* LEDB -> PMU_STAT */
> -	{
> -		.provider = "twl-pwmled",
> -		.index = 1,
> -		.dev_id = "leds_pwm",
> -		.con_id = "beagleboard::pmu_stat",
> -		.period = 7812500,
> -		.polarity = PWM_POLARITY_NORMAL,
> -	},
> +	PWM_LOOKUP("twl-pwmled", 1, "leds_pwm", "beagleboard::pmu_stat",
> +		   7812500, PWM_POLARITY_NORMAL),
>  };
>  
>  static struct led_pwm pwm_leds[] = {
> -- 
> 1.9.1
> 
