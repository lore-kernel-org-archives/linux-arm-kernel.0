From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 18 Jun 2010 07:27:09 +0200
Subject: gpiolib and sleeping gpios
In-Reply-To: <4C1A980F.8080908@bluewatersys.com>
References: <4C1A980F.8080908@bluewatersys.com>
Message-ID: <20100618052709.GA6392@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ryan,

On Fri, Jun 18, 2010 at 09:47:59AM +1200, Ryan Mallon wrote:
> Then all drivers can just call gpio_(set/get)_value and any attempts to
> use sleeping gpios from an non-sleeping context will be caught by the
> might_sleep_if check. Is there something I am missing about this?
The downside is that you change the semantic of gpio_get_value (and
gpio_set_value I assume?).  But as calling gpio_get_value with a gpio
that gpio_cansleep() is an error anyhow, so I think that's OK.  The big
pro is that the API is simplified.
 
> I can prepare a patch which combines the non-sleeping and sleeping
> variants, but I wanted to check that I'm not missing something
> fundamental first.
I will happily look at such a patch and give my comments.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
