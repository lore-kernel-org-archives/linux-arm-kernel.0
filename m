From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 15 Nov 2014 00:26:01 +0100
Subject: [PATCH] gpio: mxs: implement get_direction callback
In-Reply-To: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
Message-ID: <20141114232601.GW27002@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Nov 14, 2014 at 11:27:06PM +0100, Janusz Uzycki wrote:
> Function gpiod_get_direction() of gpiolib calls get_direction()
> callback. If chip doesn't implement it EINVAL error is returned.
> The function doesn't use for returned value shadowed FLAG_IS_OUT
> bit of gpio_desc.flags field so the callback is required.
This sounds like a bugfix but "required" is wrong as AFAIR this call is
optional and hardly used. Or did that change? The only drawback is that
the debug output for (by Linux) uninitialized gpios is wrong.

Also the grammar of you sentence isn't German enough to sound correct.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
