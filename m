From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 Feb 2013 09:48:12 +0000
Subject: [PATCH v2 12/12] clocksource: samsung-time: Add Device Tree
 support
In-Reply-To: <1361033044-27629-13-git-send-email-tomasz.figa@gmail.com>
References: <1361033044-27629-1-git-send-email-tomasz.figa@gmail.com>
 <1361033044-27629-13-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130218094812.GA23831@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[...]

> +static void samsung_timer_parse_dt(struct device_node *np,
> +					const struct of_device_id *match)
> +{
> +	int i;
> +	u32 val;
> +
> +	timer_base = of_iomap(np, 0);
> +	if (!timer_base)
> +		panic("failed to map timer registers");
> +
> +	for (i = 0; i < SAMSUNG_PWM_NUM; ++i)
> +		timer_variant.irqs[i] = irq_of_parse_and_map(np, i);
> +
> +	if (!timer_variant.irqs[timer_source.event_id])
> +		panic("no clock event irq provided");
> +
> +	switch ((unsigned int)match->data) {
> +	case TYPE_S3C24XX:
> +		timer_variant.bits = 16;
> +		timer_variant.prescale = 25;
> +		timer_variant.prescale = 50;

Redundant conflicting assignments here.

Thanks,
Mark.
