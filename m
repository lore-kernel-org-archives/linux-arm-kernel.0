From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Fri, 13 Jan 2012 15:52:20 +0000
Subject: omap clocksource timer selection: dmtimer OR 32K-Sync timer
In-Reply-To: <4F104B87.8080003@ti.com>
References: <79CD15C6BA57404B839C016229A409A8317A4E2E@DBDE01.ent.ti.com>
 <4F104B87.8080003@ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A8317A52F0@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 20:49:35, Cousson, Benoit wrote:
> On 1/13/2012 1:21 PM, Hiremath, Vaibhav wrote:
> > Hi,
> >
> > In case of AM33xx family of devices, we do not have 32K Sync timer
> > (32K Counter) available; and the current implementation is based on
> > compile-time option, where clock-source is chosen by something like,
> >
> > File - arch/arm/mach-omap2/timer.c
> >
> > #ifdef CONFIG_OMAP_32K_TIMER
> > static void __init omap2_gp_clocksource_init(int unused, const char *dummy)
> > {
> > ...
> > }
> > #else
> > static void __init omap2_gp_clocksource_init(int unused, const char *dummy)
> > {
> > ...
> > }
> > #endif
> >
> >
> > But in order to support multi-omap build, we must
> > make run-time decision to use the timer for kernel clock-source, either of -
> >
> >   - DMTIMER
> >   - 32K Sync Timer
> >
> > The DMTIMER is already migrated to the HWMOD framework, but 32K Timer code
> > has not yet migrated to it. So the question here is,
> 
> A series was sent to do that by Felipe last year, but we somehow forgot 
> to rebase it on newer kernel and thus never reposted it.
> 

If you are ok, I can help you here. Can you please point me to git repo for
the same.

And also, this is important for AM33xx support in mainline.

Thanks,
Vaibhav

> Benoit
> 
