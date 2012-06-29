From: tony@atomide.com (Tony Lindgren)
Date: Fri, 29 Jun 2012 05:03:25 -0700
Subject: [PATCH 2/3] OMAP2+ devices add mac address allocation register api
In-Reply-To: <4FED7E6A.4090207@linaro.org>
References: <20120629054404.11091.31289.stgit@build.warmcat.com>
 <20120629055516.11091.82899.stgit@build.warmcat.com>
 <20120629094055.GB4202@atomide.com> <4FED7E6A.4090207@linaro.org>
Message-ID: <20120629120325.GD4202@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Andy Green <andy.green@linaro.org> [120629 03:12]:
> On 06/29/12 17:40, the mail apparently from Tony Lindgren included:
> >
> >This is a bit similar to platform data callback functions that we are
> >trying to get rid of. And as the question "how do we replace platform
> >data callback functions" is still open for things like this, few
> >questions come to mind that should be discussed:
> >
> >1. How is this a better solution to passing the generated mac address in
> >    platform data to the driver?
> 
> Well, I initially did this over a year ago as a generic way to pass
> platform data to devices that are appearing through deferred or
> async probing, like USB bus and SDIO bus.  It was not understood
> what the goal was by the people looking after those subsystems.

OK..
 
> >2. Is this really how we want to pass the board generated mac addresses
> >    and other dynamically generated data to the drivers that are device
> >    tree based?
> 
> The issue is that both these busses have an async probe, in the case
> of USB stack the maintainer was not interested last year in adding
> platform data.  Maybe it changed but that's my understanding.

OK, I'd like to hear Arnds comments on the #2 above too as this is
a more generic issue.
 
> >3. What about mac address in board-generic.c when booting panda with
> >    device tree?
> 
> I don't mind adapting it for that case.

Just to try to think about some alternatives, how about something like
this: This all could be a driver called soft-mac or something that does
what your patches are doing. Except then it would be completely generic
and would be able to take device names and mac addresses from platform
data or from devicetree.
 
> >Also, what happens if the user has set the mac address and you replugs the
> >cable or device? Do we now overwrite it? Might be worth checking that this
> >follows the standard behaviour..
> 
> This is only useful for devices that are soldered on your board, and
> have deterministic "device paths" as is the case with Panda Ethernet
> and Wlan module that both benefit from this treatment.  If you mean
> pulling the RJ45 cable, it doesn't change anything about the MAC I
> can confirm.

OK

Tony
