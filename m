From: khilman@ti.com (Kevin Hilman)
Date: Mon, 27 Jun 2011 09:41:42 -0700
Subject: [PATCH 08/10] omap2+: Use dmtimer macros for clocksource
In-Reply-To: <20110627104815.GL23145@atomide.com> (Tony Lindgren's message of
	"Mon, 27 Jun 2011 03:48:16 -0700")
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092345.357.11154.stgit@kaulin> <87iprwa2xx.fsf@ti.com>
	<20110627075429.GF23145@atomide.com>
	<20110627104815.GL23145@atomide.com>
Message-ID: <87zkl3cjll.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Tony Lindgren <tony@atomide.com> [110627 00:50]:
>> * Kevin Hilman <khilman@ti.com> [110623 10:06]:
>> > Tony Lindgren <tony@atomide.com> writes:
>> > > +
>> > > +	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source);
>> > 
>> > This function makes calls into "real" driver, but is called from
>> > sys_timer.init so happens before driver is initialized.
>> 
>> That one is the static omap2+ specific function that can be passed
>> to the dmtimer device driver as a function pointer in the later
>> patches. 
>>  
>> > > +	omap_dm_timer_set_load_start(&clksrc, 1, 0);
>> > 
>> > Here's another call into the real driver.  I think you need
>> > __omap_dm_timer_set_load_start() here.
>> 
>> Thanks, that's correct. Will fix that one.
>
> Here's this one updated. Looks like I still have your Reviewed-by
> lines from the last time this series got posted. Can you please check
> if those are still valid?

Yes, they're still valid as I've now been through the whole series.

Kevin
