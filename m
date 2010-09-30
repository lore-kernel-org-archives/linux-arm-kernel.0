From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 30 Sep 2010 10:11:49 -0700
Subject: [PATCH] OMAP2PLUS: WDT: Fix: Disable WDT after reset during init
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CD03185@dbde02.ent.ti.com>
	(Santosh Shilimkar's message of "Thu, 30 Sep 2010 22:35:05 +0530")
References: <1285834270-32766-1-git-send-email-charu@ti.com>
	<4CA45341.3080300@ti.com> <87vd5njpyq.fsf@deeprootsystems.com>
	<4CA49ADE.6080202@ti.com> <20100930150713.GG3117@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CCF813E@dbde02.ent.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CD03185@dbde02.ent.ti.com>
Message-ID: <87bp7ff962.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:

>> -----Original Message-----
>> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
>> owner at vger.kernel.org] On Behalf Of Varadarajan, Charulatha
>> Sent: Thursday, September 30, 2010 9:25 PM
>> To: Tony Lindgren; Cousson, Benoit
>> Cc: Kevin Hilman; Menon, Nishanth; wim at iguana.be; linux-
>> omap at vger.kernel.org; linux-watchdog at vger.kernel.org; linux-arm-
>> kernel at lists.infradead.org; paul at pwsan.com; Nayak, Rajendra; Basak, Partha
>> Subject: RE: [PATCH] OMAP2PLUS: WDT: Fix: Disable WDT after reset during
>> init
>> 
>> Tony/ Benoit,
>> 
>> > >
>> > > I think that disabling it should be done only if the CONFIG_OMAP_WDT
>> > > is not set.
>> >
>> > How about disabling is done always unless CONFIG_WATCHDOG_NOWAYOUT
>> > is set?
>> 
>> As given in the patch description, this patch does a disable of watchdog
>> timer, during init, to avoid the system rebooting that happens due to
>> enabling of watchdog timer after a reset of the module (during hwmod init).
>> 
>> According to the default WDT registers values, the system reboot would
>> happen in ~10s if watchdog is enabled with default values. Hence, after
>> a WDT module reset during init, the watchdog has to be disabled within 10s
>> otherwise the system will keep rebooting.
>> 
>> Hence irrespective of CONFIG_WATCHDOG_NOWAYOUT/ CONFIG_OMAP_WDT,
>> the watchdog timer needs to be disabled after a WDT reset has happened.
>> 
> One more option is to avoid the software reset using the CONFIG_OMAP_WDT
> flag. Something like below.

This was already proposed by Charu, and rejected.

Doing this means we have a dependency on particular bootloader init, and
we'd like to get rid of *all* assumptions about what the bootloader does
(or does not do.)

Kevin
