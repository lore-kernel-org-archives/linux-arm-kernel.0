From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 3 Oct 2012 20:08:55 +0100
Subject: [PATCH RFC 1/2] gpio: Add a block GPIO API to gpiolib
In-Reply-To: <1348780923-27428-1-git-send-email-stigge@antcom.de>
References: <1348780923-27428-1-git-send-email-stigge@antcom.de>
Message-ID: <20121003190855.GA1275@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 11:22:02PM +0200, Roland Stigge wrote:

> The recurring task of providing simultaneous access to GPIO lines (especially
> for bit banging protocols) needs an appropriate API.

> This patch adds a kernel internal "Block GPIO" API that enables simultaneous
> access to several GPIOs in the same gpio_chip (bit mapped). Further, it adds a
> sysfs interface (/sys/class/gpio/gpiochipXX/block).

It would be very useful if this had the option of falling back to
addressing the GPIOs one by one.  There's some usages that aren't
performance dependent and it'd make drivers able to run even if they're
suboptimal.
