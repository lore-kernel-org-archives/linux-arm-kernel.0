From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 10 Feb 2014 14:16:31 +0100
Subject: [PATCH] reset: Add generic GPIO reset driver.
In-Reply-To: <20140210125432.10683.86571.stgit@localhost>
References: <20140210125432.10683.86571.stgit@localhost>
Message-ID: <1392038191.6687.12.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

Am Montag, den 10.02.2014, 13:54 +0100 schrieb Martin Fuzzey:
> This driver allows GPIO lines to be used as reset signals.
> It has two main use cases:
> 
> 1) Allow drivers to reset their hardware via a GPIO line in a standard fashion
> as supplied by the reset framework.
> This allows adhoc driver code requesting GPIOs etc to be replaced with a
> single call to device_reset().

have you seen the patch at https://lkml.org/lkml/2014/1/8/190:
"reset: Add GPIO support to reset controller framework" ?

Adding a GPIO reset controller device node to the device tree is the
wrong approach for devices enumerated in the device tree. Those should
just declare their reset-gpios directly.

> 2) Allow hardware on discoverable busses to be rest via a GPIO line
> without driver modifications.
>
> Examples of the second use case include:
> * SDIO wifi modules
> * USB hub chips with a reset line

Now this is interesting. But if you export it to userspace anyway, why
not use the existing gpio sysfs API?

I think a proper solution should handle this in the kernel. For SDIO
wifi modules you usually have a powerdown line that can be implemented
as an rfkill switch.

regards
Philipp
