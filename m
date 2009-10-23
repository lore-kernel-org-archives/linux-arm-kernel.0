From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Fri, 23 Oct 2009 19:12:22 +0200
Subject: [PATCH v3 4/4] iop: implement sched_clock()
In-Reply-To: <19168.55801.851167.570526@pilspetsen.it.uu.se>
References: <19160.60691.72229.932486@pilspetsen.it.uu.se>
	<e9c3a7c20910221449i6a9f8bc6y6b3af1f2f7fe1c44@mail.gmail.com>
	<19168.55801.851167.570526@pilspetsen.it.uu.se>
Message-ID: <63386a3d0910231012o757c776ar57990ab109b9aef2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/10/23 Mikael Pettersson <mikpe@it.uu.se>:

> Actually I do have an idea what it might be. sched_clock() is
> "registered" (if you can call it that) at link-time simply by
> virtue of being defined, while the other machinery it needs
> (clocksource) is enabled at boot-time at some semi-unknown point.
> So there's an early boot-time window where calls to sched_clock()
> may occur but won't work.

Check the OMAP code arch/arm/plat-omap/common.c
See how they have a dummy clocksource omap_32k_read_dummy()
 that get used until the clocksource is set up in
omap_init_clocksource_32k(). This approach should work I guess?

Linus Walleij
