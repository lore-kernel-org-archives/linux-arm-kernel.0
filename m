From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Jul 2010 23:21:14 +0100
Subject: [PATCH] ARM: fix regression in RealView after the introduction
	of pclk
In-Reply-To: <AANLkTi=xcFsL7vCtG31v0yWfkBV+vYqQZ4z=_p-=wZnH@mail.gmail.com>
References: <1280408722-31995-1-git-send-email-linus.walleij@stericsson.com>
	<20100729135639.GE18923@n2100.arm.linux.org.uk>
	<AANLkTi=xcFsL7vCtG31v0yWfkBV+vYqQZ4z=_p-=wZnH@mail.gmail.com>
Message-ID: <20100729222114.GC28330@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 29, 2010 at 11:41:44PM +0200, Linus Walleij wrote:
> Yep that is true, currently. More like this then:

Yup - and the patch is a lot smaller.

> There is a reason why we have it on the interrupt init in ux500
> though, and that is that we want to use the clock framework to
> get the clock for the timer. If we want to fix up the hardcoded
> way it is currently done in plat-versatile/timer-sp.c we would need
> a change like this across the versatiles.

I don't think it makes sense to use the clk API for those timers -
it's rather unclear from the manuals where they get their clocks
from - or even what the magic bits in the system controller do in
terms of switching their clock source.

I've not found the magic bits which switch their clock source on
Versatile Express tiles yet either (which is why we're using the
V2M baseboard timers).
