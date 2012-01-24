From: khilman@ti.com (Kevin Hilman)
Date: Tue, 24 Jan 2012 09:47:56 -0800
Subject: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
In-Reply-To: <79CD15C6BA57404B839C016229A409A8317B0971@DBDE01.ent.ti.com>
 (Vaibhav Hiremath's message of "Tue, 24 Jan 2012 08:53:29 +0000")
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
 <1326983304-14619-2-git-send-email-hvaibhav@ti.com>
 <87mx9ej8fp.fsf@ti.com>
 <79CD15C6BA57404B839C016229A409A8317B0971@DBDE01.ent.ti.com>
Message-ID: <877h0hj8kz.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

> On Tue, Jan 24, 2012 at 05:08:50, Hilman, Kevin wrote:
>> Vaibhav Hiremath <hvaibhav@ti.com> writes:
>> 
>> > OMAP device has 32k-sync timer which is currently used as a
>> > clocksource in the kernel (omap2plus_defconfig).
>> > The current implementation uses compile time selection between
>> > gp-timer and 32k-sync timer, which breaks multi-omap build for
>> > the devices like AM33xx, where 32k-sync timer is not available.
>> >
>> > So use hwmod database lookup mechanism, through which at run-time
>> > we can identify availability of 32k-sync timer on the device,
>> > else fall back to gp-timer.
>> 
>> With the runtime detection & fallback, I suggest also removing the
>> Kconfig choice between the two as well.
>> 
> Kevin,
>
> Actually I thought of cleaning whole 32KTIMER related code,
> but then realized that, it would be major cleanup, since
> it is being used in lot of places.
>
> So let's not block this patch-series for this further cleanup.
> I will work on cleaning up the complete 32KTIMER macro and 
> submit the patches.

OK, Tony can make the call.

Kevin
