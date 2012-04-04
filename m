From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 4 Apr 2012 12:13:24 +0100
Subject: [PATCH] gpio: Device tree support for LPC32xx
In-Reply-To: <4F7B8A39.5000701@antcom.de>
References: <1333407513-18231-1-git-send-email-stigge@antcom.de>
 <20120403150430.EBA423E0436@localhost> <4F7B8A39.5000701@antcom.de>
Message-ID: <20120404111323.GA9457@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2012 at 01:39:37AM +0200, Roland Stigge wrote:
> On 03/04/12 17:04, Grant Likely wrote:

> >> +postcore_initcall(lpc32xx_gpio_init);

> ===============================================================
> Error requesting gpio 50
> ...
> gpiochip_add: registered GPIOs 0 to 7 on device: gpio_p0

> Are you sure that module_platform_driver() can already handle
> this in v3.4-rc1?

For the present moment it needs explicit handling in each GPIO user to
translate a failure to get a GPIO into -EPROBE_DEFER.  I sent a patch
which would change the default return code for failed GPIO lookups to
that which should get most users doing the right thing but I've had no
response to that patch so far so it's not in any tree.
