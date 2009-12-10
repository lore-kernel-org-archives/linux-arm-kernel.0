From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 10 Dec 2009 18:04:04 +0000
Subject: [PATCH V2 07/09] led: enable led in 88pm860x
In-Reply-To: <771cded00912091957n7662b62bv519f10ed9f992c75@mail.gmail.com>
References: <771cded00912090516v25ca013ah6595020e6b3624d7@mail.gmail.com>
	<20091209151432.GC32223@rakim.wolfsonmicro.main>
	<771cded00912091957n7662b62bv519f10ed9f992c75@mail.gmail.com>
Message-ID: <20091210180403.GA11889@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 09, 2009 at 10:57:59PM -0500, Haojian Zhuang wrote:

> +	on = *delay_on;
> +	if ((on < LED_BLINK_ON_MIN) || (on > LED_BLINK_ON_MAX))
> +		return -EINVAL;

You're returning -EINVAL here but...

> +	period = on + *delay_off;
> +	if (period < LED_BLINK_PERIOD_MIN)
> +		period = LED_BLINK_PERIOD_MIN;
> +	if (period > LED_BLINK_PERIOD_MAX)
> +		period = LED_BLINK_PERIOD_MAX;

...I'd expect it also here?
