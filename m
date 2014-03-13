From: tony@atomide.com (Tony Lindgren)
Date: Thu, 13 Mar 2014 13:48:52 -0700
Subject: [RFC 4/5] clocksource: omap-timer: Introduce clocksource driver
 for OMAP SoCs
In-Reply-To: <1394742919-32163-5-git-send-email-joelf@ti.com>
References: <1394742919-32163-1-git-send-email-joelf@ti.com>
 <1394742919-32163-5-git-send-email-joelf@ti.com>
Message-ID: <20140313204851.GB23432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Joel Fernandes <joelf@TI.com> [140313 13:43]:
> We introduce functions to initialize clocksource and clockevent, use
> CLOCKSOURCE_OF_DECLARE to declare the clocksource, and handle the clocksource
> selection on a per-SoC basis (Currently only AM335x is supported). Powering up
> of the timer will be done with the help of the mach-omap layer function that's
> introduced earlier in the series.
> 
> We make a local copy of dmtimer API for use by clocksource, the original
> dmtimer API in plat-omap is kept as-is till the migration of all SoCs is
> completed after which it can't be deleted.
> 
> Signed-off-by: Joel Fernandes <joelf@ti.com>
> ---
>  drivers/clocksource/Makefile     |    1 +
>  drivers/clocksource/omap-timer.c | 1157 ++++++++++++++++++++++++++++++++++++++
>  drivers/clocksource/omap-timer.h |  422 ++++++++++++++
>  3 files changed, 1580 insertions(+)
>  create mode 100644 drivers/clocksource/omap-timer.c
>  create mode 100644 drivers/clocksource/omap-timer.h

Hmm this leaves duplicate arch/arm/plat-omap/dmtimer.c code, please
sort out that issue too by allowing omap1 and omap3 still to use
the legacy timer init functions but with timer code under
drivers/clocksource/omap-timer.c.

And not the that drivers/clocksource/omap-timer.h won't be needed at
all, those defines can stay private to the drivers/clocksource/omap-timer.c.

So this patch really should just be moving of the code to the new
location.

Regards,

Tony
