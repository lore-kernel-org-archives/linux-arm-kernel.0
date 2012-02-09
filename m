From: khilman@ti.com (Kevin Hilman)
Date: Wed, 08 Feb 2012 16:01:42 -0800
Subject: [PATCH] gpio: omap: be more aggressive with pm_runtime
In-Reply-To: <1328707614-20146-1-git-send-email-balbi@ti.com> (Felipe Balbi's
 message of "Wed, 8 Feb 2012 15:26:54 +0200")
References: <1328707614-20146-1-git-send-email-balbi@ti.com>
Message-ID: <877gzwyivt.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe Balbi <balbi@ti.com> writes:

> try to keep gpio block suspended as much as possible.
>
> Tested with pandaboard and a sysfs exported gpio.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---

Looks like you need a few more get/puts around other places where
registers are accessed.  It currently causes a boot crash on OMAP3 in
_set_gpio_triggering().

Did you test GPIO wakeups?  both IO ring wakeups and GPIO module-level
wakeups?

Kevin
