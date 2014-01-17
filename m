From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 17 Jan 2014 12:40:02 -0700
Subject: More GPIO madness on iMX6 - and the crappy ARM port of Linux
In-Reply-To: <20140117184731.GE15937@n2100.arm.linux.org.uk>
References: <20140117184731.GE15937@n2100.arm.linux.org.uk>
Message-ID: <52D98712.3070103@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2014 11:47 AM, Russell King - ARM Linux wrote:
> So, we have this wonderful GPIO layer which abstracts GPIO stuff and
> hides stuff.  It's really wonderful, because you don't have to care
> about how the GPIOs are actually accessed in drivers anymore.
...
> 1. What should gpio_get_value() return for an output?

Some HW can't ever read back the value of an output pin, so isn't
calling gpio_get_value() undefined for output pins?

> 2. What should be reported in /sys/kernel/debug/gpio for an output?

Shouldn't it indicate that the pin is an output, and say nothing about
the input value?
