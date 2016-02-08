From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 8 Feb 2016 15:06:14 +0100
Subject: [PATCH v1] clocksource: atmel-pit: register as a sched_clock
In-Reply-To: <56B89910.3060305@linaro.org>
References: <1454606493-15094-1-git-send-email-romain.izard.pro@gmail.com>
 <56B89910.3060305@linaro.org>
Message-ID: <20160208150614.5e87133e@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Alexandre

Hi Daniel,

On Mon, 8 Feb 2016 14:33:04 +0100
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> On 02/04/2016 06:21 PM, Romain Izard wrote:
> > Register the counter of the Periodic Interval Timer as a possible source
> > for sched_clock. This provides a better precision than the jiffies-based
> > default.
> >
> > Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> 
> Nicolas, Boris,
> 
> Are you ok with this patch ?

Not sure yet :). On most platforms we are also declaring a clocksource
based on the TCB IP, and this one provides a better precision than the
PIT clocksource.
What happens if the PIT is de-activated while it's still supposed to
provide the sched_clock(). Is there a way to flag the clocksource as
still needed so that the core does not shut it down by when the TCB
clocksource comes in.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
