From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 4 Apr 2012 14:36:08 +0800
Subject: [PATCH v5 01/16] pwm: Add PWM framework support
In-Reply-To: <1332945238-14897-2-git-send-email-thierry.reding@avionic-design.de>
References: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
 <1332945238-14897-2-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20120404063605.GB7264@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A couple of trivial editorial errors, otherwise,

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

On Wed, Mar 28, 2012 at 04:33:43PM +0200, Thierry Reding wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> This patch adds framework support for PWM (pulse width modulation) devices.
> 
> The is a barebone PWM API already in the kernel under include/linux/pwm.h,

s/The/There

> but it does not allow for multiple drivers as each of them implements the
> pwm_*() functions.
> 
...

> +/**
> + * pwm_request() - request a PWM device
> + * @pwm: global PWM device index

s/pwm/pwm_id

> + * @label: PWM device label
> + */
> +struct pwm_device *pwm_request(int pwm_id, const char *label)
...

> +/**
> + * struct pwm_chip - abstract a PWM
> + * @label: for diagnostics
> + * @owner: helps prevent removal of modules exporting active PWMs

The doc needs an update.

Regards,
Shawn

> + * @ops: The callbacks for this PWM
> + */
> +struct pwm_chip {
> +	int			pwm_id;
> +	const char		*label;
> +	struct pwm_ops		*ops;
> +};
> +
> +int pwmchip_add(struct pwm_chip *chip);
> +int pwmchip_remove(struct pwm_chip *chip);
> +#endif
> +
>  #endif /* __LINUX_PWM_H */
> -- 
> 1.7.9.4
> 
