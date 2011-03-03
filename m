From: khilman@ti.com (Kevin Hilman)
Date: Thu, 03 Mar 2011 09:05:51 -0800
Subject: [PATCH 12/17] omap4: pm-debug: Add wakeup timer and debug counters
In-Reply-To: <ff69224b634bfd89405d29a720755b64@mail.gmail.com> (Santosh
	Shilimkar's message of "Thu, 3 Mar 2011 22:04:27 +0530")
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
	<1298112158-28469-13-git-send-email-santosh.shilimkar@ti.com>
	<87hbbl2l1y.fsf@ti.com>
	<ff69224b634bfd89405d29a720755b64@mail.gmail.com>
Message-ID: <87r5aoqgls.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman at ti.com]
>> Sent: Thursday, March 03, 2011 4:21 AM
>> To: Santosh Shilimkar
>> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
>> Subject: Re: [PATCH 12/17] omap4: pm-debug: Add wakeup timer and
>> debug counters
>>
>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>
>> > This patch adds configurable wakeup timer support in suspend. Also
>> > for statistics pm counter support is added.
>> >
>> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> > Reviewed-by: Kevin Hilman <khilman@ti.com>
>> > ---
>> >  arch/arm/mach-omap2/omap4-mpuss-lowpower.c |    8 ++++++++
>> >  arch/arm/mach-omap2/pm-debug.c             |    6 ++++--
>> >  arch/arm/mach-omap2/pm44xx.c               |    5 +++++
>> >  3 files changed, 17 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
>> b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
>> > index ab2e101..5e0141e 100644
>> > --- a/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
>> > +++ b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
>> > @@ -287,6 +287,10 @@ int omap4_enter_lowpower(unsigned int cpu,
>> unsigned int power_state)
>> >  	if (cpu)
>> >  		goto cpu_prepare;
>> >
>> > +#ifdef CONFIG_PM_DEBUG
>> > +	pwrdm_pre_transition();
>> > +#endif
>>
>> Why the #ifdef?
>>
> Because these stats updates are quite expensive
> in low power code and for the production kernel
> you don't need this extra penalty.

OK, then please fix this in the powerdomain code (or header.)

c.f. "#ifdefs are ugly" section of Documentation/SubmittingPatches

Kevin
