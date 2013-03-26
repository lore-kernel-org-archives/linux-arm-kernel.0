From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Mar 2013 14:31:36 +0000
Subject: [PATCH 0/8] SIRF multiplatform support
In-Reply-To: <CAGsJ_4ztS_jGsQaLm3URDjPrNSoP6PU6PR73f=X72YG-d4_Yfw@mail.gmail.com>
References: <1363779679-16880-1-git-send-email-arnd@arndb.de>
 <201303251133.31426.arnd@arndb.de>
 <CAGsJ_4ztS_jGsQaLm3URDjPrNSoP6PU6PR73f=X72YG-d4_Yfw@mail.gmail.com>
Message-ID: <201303261431.37027.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 March 2013, Barry Song wrote:
> everything is fine except that:
> 1. Shawn Guo's uncompress debug patch is not in the tree, so the
> uncompress debug is break. but that is not an issue

Right.

> 2. i want to change:
> #define SIRFSOC_NUM_IRQS                128
> to:
> #define SIRFSOC_NUM_IRQS                64
> the old 128 is suitable for marco, in fact prima2/atlas6 is 64. in
> order that all SoCs can use the same irqs.h headfile, i pick the
> biggest value. since now we have moved to linear irq, i want to fix it
> back.
>
> then nr_irqs in DT_MACHINE_START(ATLAS6_DT/PRIMA2_DT should also take 64.

Yes, sounds good.
 
> 3. will we have similar codes between prima2 and marco for initilizing
> timer tick?
> CLOCKSOURCE_OF_DECLARE(sirfsoc_marco_timer, "sirf,marco-tick",
> sirfsoc_of_timer_init );
> CLOCKSOURCE_OF_DECLARE(sirfsoc_prima2_timer, "sirf,prima2-tick",
> sirfsoc_prima2_timer_init);
> 
> will we change "CLOCKSOURCE_OF_DECLARE(sirfsoc_marco_timer,
> "sirf,marco-tick", sirfsoc_of_timer_init )" to things like
> "CLOCKSOURCE_OF_DECLARE(sirfsoc_marco_timer, "sirf,marco-tick",
> sirfsoc_marco_timer_init )" as prima2 does and drop
> 
> anyway, this is a trivial issue.

Yes, it seemed less invasive to do it without that change for marco.

Since these changes are now just cosmetic, how about I pull the branch
I have into the arm-soc tree and you do any further changes you'd like
on top?

It may also be a good point in time now to rename the directory to
mach-sirf or mach-sirfsoc now as you suggested for an earlier release,
since we have moved a lot of code out of it now. Any patches against
the drivers that are getting moved will have to change anyway.

	Arnd
