From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 21 Jul 2016 14:52:24 +0200
Subject: [PATCH v2 03/10] Clocksource: add nuc970 clocksource driver
In-Reply-To: <26830152.1oBSpuVOM0@wuerfel>
References: <1468135649-19980-1-git-send-email-vw@iommu.org>
 <3277576.eNgdG7zPqq@wuerfel> <57849D2B.60305@iommu.org>
 <26830152.1oBSpuVOM0@wuerfel>
Message-ID: <20160721125224.GA10047@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2016 at 10:28:35AM +0200, Arnd Bergmann wrote:

[ ... ]

> > > Also the init function has changed its return type in linux-next:
> > >
> > >> +static void __init nuc970_timer_of_init(struct device_node *node)
> > >
> > > This now needs to return an error code or we get:
> > >
> > > ../include/linux/of.h:1004:20: error: comparison of distinct pointer types lacks a cast [-Werror]
> > >          .data = (fn == (fn_type)NULL) ? fn : fn  }
> > >
> > > Daniel Lezcano seems to have implemented a migration strategy, but I
> > > can't see what you are supposed to do here, since the
> > > CLOCKSOURCE_OF_DECLARE_RET macro is no longer part of linux-next.
> > 
> > Wait for Daniel's comments? or what should I do now?
> 
> Yes, let's see what he says. I guess from the timing, this will probably
> have to wait for linux-4.9 anyway, and then we have no problem because the
> API change will make it into 4.8.

CLOCKSOURCE_OF_DECLARE_RET was renamed back to CLOCKSOURCE_OF_DECLARE but it 
expects now an init function returning an 'int'.

These changes are now in tip/timers/core, so in linux-next.
