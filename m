From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 9 Dec 2009 15:14:32 +0000
Subject: [PATCH V2 07/09] led: enable led in 88pm860x
In-Reply-To: <771cded00912090516v25ca013ah6595020e6b3624d7@mail.gmail.com>
References: <771cded00912090516v25ca013ah6595020e6b3624d7@mail.gmail.com>
Message-ID: <20091209151432.GC32223@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 09, 2009 at 08:16:21AM -0500, Haojian Zhuang wrote:

> +	period = on + *delay_off;
> +	if (period < LED_BLINK_PERIOD_MIN)
> +		period = LED_BLINK_PERIOD_MIN;
> +	if (period > LED_BLINK_PERIOD_MAX)
> +		period = LED_BLINK_PERIOD_MAX;

If the hardware can't support the blink settings requested the driver
ought to return an error - there's a software fallback which will blink
the LED using a timer instead.
