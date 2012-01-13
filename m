From: tony@atomide.com (Tony Lindgren)
Date: Fri, 13 Jan 2012 08:50:03 -0800
Subject: omap clocksource timer selection: dmtimer OR 32K-Sync timer
In-Reply-To: <CAMQu2gxkBV87YQE7SPmLXh0RZBR+SNHzHE5H-PVjuef+1UZp8Q@mail.gmail.com>
References: <79CD15C6BA57404B839C016229A409A8317A4E2E@DBDE01.ent.ti.com>
 <CAMQu2gxYQOHX8n2RLfkLBw5hQMdvH389DfrguLtzpLcpmqBQMA@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A8317A4FD9@DBDE01.ent.ti.com>
 <CAMQu2gxkBV87YQE7SPmLXh0RZBR+SNHzHE5H-PVjuef+1UZp8Q@mail.gmail.com>
Message-ID: <20120113165003.GJ15299@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [120113 06:08]:
> On Fri, Jan 13, 2012 at 2:42 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> > On Fri, Jan 13, 2012 at 18:19:24, Shilimkar, Santosh wrote:
> >> > ? ...
> >> > ? };
> >> >
> >> > ? We need to have similar entries in all devices where 32K timer is present.
> >> >
> >> > 2) OR simply add another cpu_is_am33xx() and then fall back to dmtimer?
> >> > ? Just to prove this, everything works here, I modified the code for this
> >> > ? and tested it on both AM335x EVM and AM37xEVM and it works fine for me.
> >> >
> >> >
> >> > Any comments?? OR Better approach? OR anything which I am missing here?

Why don't you just add a new entry to mach-omap2/timer.c using the OMAP_SYS_TIMER
macro?

See for example the omap3_secure timer set up. That should allow
specifying the clock source already.

Regards,

Tony
