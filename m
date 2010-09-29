From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 29 Sep 2010 08:43:01 -0700
Subject: [PATCH v8 0/6] OMAP: WDT: Implement WDT in hwmod way
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CD02BA7@dbde02.ent.ti.com>
	(Charulatha Varadarajan's message of "Wed, 29 Sep 2010 20:16:41
	+0530")
References: <1285252363-3630-1-git-send-email-charu@ti.com>
	<877hi5740v.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CD02B1E@dbde02.ent.ti.com>
	<87d3rw62ft.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CD02BA7@dbde02.ent.ti.com>
Message-ID: <87y6ak1rp6.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Varadarajan, Charulatha" <charu@ti.com> writes:

[...]

>> 
>> Instead, I would rather have a small piece of code in omap_init_wdt()
>> which disarms the watchdog so we don't have any assumptions about
>> bootloader behavior.
>> 
>> The question remains whether this disarm should be
>> #ifndef CONFIG_OMAP_WATCHDOG or if it should happen all the time.  In
>> case the watchdog is a module, it's probe may not happen within the
>> timeout period and they system may reboot also, so I lean towards
>> disarming the watchdog unconditionally.
>
> Agreed. But this shall be handled in mach-omap2/devices.c by directly
> accessing the watchdog registers and disabling it, as the watchdog driver
> would not be available by this time. 

Correct.

> If this okay, I would send a separate patch on top my hwmod series to
> handle this.

Yes please.

Thanks,

Kevin
