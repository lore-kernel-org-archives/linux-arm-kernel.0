From: khilman@ti.com (Kevin Hilman)
Date: Thu, 23 Jun 2011 09:47:47 -0700
Subject: [PATCH 08/10] omap2+: Use dmtimer macros for clocksource
In-Reply-To: <87iprwbm9p.fsf@ti.com> (Kevin Hilman's message of "Thu, 23 Jun
	2011 08:28:02 -0700")
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092345.357.11154.stgit@kaulin> <87iprwbm9p.fsf@ti.com>
Message-ID: <87ei2kbiks.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@ti.com> writes:

> Tony Lindgren <tony@atomide.com> writes:
>
>> Use dmtimer macros for clocksource. As with the clockevent,
>> this allows us to initialize the rest of dmtimer code later on.
>>
>> Note that eventually we will be initializing the timesource
>> from init_early so sched_clock will work properly for
>> CONFIG_PRINTK_TIME.
>>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>> Reviewed-by: Kevin Hilman <khilman@ti.com>
>
> [...]
>
>> +/* Setup free-running counter for clocksource */
>> +static void __init omap2_gp_clocksource_init(int gptimer_id,
>> +						const char *fck_source)
>> +{
>> +	int res;
>> +
>> +	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source);
>> +	BUG_ON(res);
>
> This is a change from previous code where the clocksource was requesting
> any timer, not a specific one.   
>
> Also, you're using the same gptimer_id here as the clockevent, which
> means this is guaranteed to fail.

Nevermind, ignore this comment.

I misread the macros.

Sorry for the noise.

Kevin
