From: johnstul@us.ibm.com (John Stultz)
Date: Wed, 18 Jul 2012 16:48:02 -0700
Subject: [PATCH v9 1/9] clocksource: time-armada-370-xp: Marvell Armada
 370/XP SoC timer driver
In-Reply-To: <1341588221-3822-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1341588221-3822-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1341588221-3822-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <50074B32.8090607@us.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2012 08:23 AM, Thomas Petazzoni wrote:
> From: Gregory Clement <gregory.clement@free-electrons.com>
>
> Timer 0 is used as free-running clocksource, while timer 1 is used as
> clock_event_device.

I don't see the any clocksource in this patch.  Why is this tagged 
clocksource?

I'm also not a huge fan of adding clockevent drivers to 
drivers/clocksource/.

Further, LinusW and I have different opinions on this (and its not that 
huge of an issue), but I'd really prefer to see additions to 
drivers/clocksource be only for clocksources that are likely to be 
shared *between architectures*.

Similarly, I'd prefer architecture specific clocksources (like TSC on 
x86,  timebase on ppc, etc) stay in the arch subdir, just so theirs a 
clear ownership of the driver (ie: if in 10 years specific hw support is 
dropped from the arch directory, we don't end up with zombie drivers 
that live on because generic driver maintainers don't know what hardware 
they're actually connected to).

(But I'm somewhat flexible on this last point, as long as there really 
is a chance it might be shared at some point)

thanks
-john
