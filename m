From: charu@ti.com (Varadarajan, Charulatha)
Date: Thu, 30 Sep 2010 22:36:42 +0530
Subject: [PATCH] OMAP2PLUS: WDT: Fix: Disable WDT after reset during init
In-Reply-To: <4CA4C17F.7060106@ti.com>
References: <1285834270-32766-1-git-send-email-charu@ti.com>
	<4CA45341.3080300@ti.com> <87vd5njpyq.fsf@deeprootsystems.com>
	<4CA49ADE.6080202@ti.com>,<20100930150713.GG3117@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CCF813E@dbde02.ent.ti.com>,
	<4CA4C17F.7060106@ti.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CCF8142@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Tony/ Benoit,
>>
>>>>
>>>> I think that disabling it should be done only if the CONFIG_OMAP_WDT
>>>> is not set.
>>>
>>> How about disabling is done always unless CONFIG_WATCHDOG_NOWAYOUT
>>> is set?
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
> 
> No, not necessarily, this is the whole point about a watchdog, you need
> just need to ping it to prove that the system is alive.
> 

Agreed

> In case you didn't notice, every watchdogs are started during a cold
> reset since OMAP1610. Even Phoenix contains a watchdog that is started
> by default.
> This is by construction... and this is done like that for a good reason.

Yes.

> So stopping a watchdog just after the reset in a bootloader is not
> necessarily the behavior that user of a watchdog are expecting,
> otherwise it will not be started by default at boot time.

But, how do we handle this? enable INIT_NO_RESET flag?

>
> In your description, it looks like this behavior is a HW bug that we
> have to fix...

Sorry if it sounded like that. 

> It is just the way it is supposed to work.

Yes. That's correct

Regards,
Benoit
