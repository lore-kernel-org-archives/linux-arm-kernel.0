From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 05 Oct 2015 22:23:29 +0200
Subject: [PATCH 01/17] ARM: pxa: cm-x300: Use PWM lookup table
In-Reply-To: <1444034997-9805-2-git-send-email-thierry.reding@gmail.com>
 (Thierry Reding's message of "Mon, 5 Oct 2015 10:49:41 +0200")
References: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
 <1444034997-9805-2-git-send-email-thierry.reding@gmail.com>
Message-ID: <87fv1pawu6.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry Reding <thierry.reding@gmail.com> writes:

> @@ -305,11 +306,14 @@ static inline void cm_x300_init_lcd(void) {}
>  #endif
>  
>  #if defined(CONFIG_BACKLIGHT_PWM) || defined(CONFIG_BACKLIGHT_PWM_MODULE)
> +static struct pwm_lookup cm_x300_pwm_lookup[] = {
> +	PWM_LOOKUP("pxa27x-pwm.0", 1, "pwm-backlight.0", NULL, 10000,
> +		   PWM_POLARITY_NORMAL),
> +};
That looks weird. It was pwm_id = 2, and I can't find the "2" in the statement
above. I would gladly fix it myself, but I wonder where that "2" should go ...

> +
>  static struct platform_pwm_backlight_data cm_x300_backlight_data = {
> -	.pwm_id		= 2,
>  	.max_brightness	= 100,
>  	.dft_brightness	= 100,
> -	.pwm_period_ns	= 10000,
>  	.enable_gpio	= -1,
>  };

Cheers.

-- 
Robert
