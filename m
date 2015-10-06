From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 7 Oct 2015 01:24:38 +0200
Subject: [PATCH 09/11] clocksource: add TI 32.768 Hz counter driver
In-Reply-To: <1444150927-14771-10-git-send-email-balbi@ti.com>
References: <1444150927-14771-1-git-send-email-balbi@ti.com>
 <1444150927-14771-10-git-send-email-balbi@ti.com>
Message-ID: <56145836.4070304@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/2015 07:02 PM, Felipe Balbi wrote:
> Introduce a new clocksource driver for Texas
> Instruments 32.768 Hz device which is available
> on most OMAP-like devices.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Hi Felipe,

With the couple of nits below fixed, you can my:

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

[ ... ]

> +#define OMAP2_32KSYNCNT_REV_OFF		0x0
> +#define OMAP2_32KSYNCNT_REV_SCHEME	(0x3 << 30)
> +#define OMAP2_32KSYNCNT_CR_OFF_LOW	0x10
> +#define OMAP2_32KSYNCNT_CR_OFF_HIGH	0x30
> +
> +struct ti_32k {
> +	void __iomem		*base;
> +	void __iomem		*counter;
> +	struct clocksource	cs;
> +};
> +#define to_ti_32k(cs)	(container_of((cs), struct ti_32k, cs))

Usually a static inline is used instead of a macro for that.

> +static cycle_t ti_32k_read_cycles(struct clocksource *cs)
> +{
> +	struct ti_32k		*ti = to_ti_32k(cs);

format


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
