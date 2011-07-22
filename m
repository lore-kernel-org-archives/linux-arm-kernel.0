From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Jul 2011 10:30:53 +0100
Subject: [RFC PATCH v9 2/4] ARM: gic: Add PPI registration interface
In-Reply-To: <4E28C290.3090604@codeaurora.org>
References: <1311267448-14652-1-git-send-email-marc.zyngier@arm.com>	<1311267448-14652-3-git-send-email-marc.zyngier@arm.com>
	<4E28C290.3090604@codeaurora.org>
Message-ID: <4E29434D.6020007@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/07/11 01:21, Jeff Ohlstein wrote:
> Marc Zyngier wrote:
>> @@ -298,14 +289,23 @@ int __cpuinit local_timer_setup(struct clock_event_device *evt)
>>  		clockevent_delta2ns(0xf0000000 >> clock->shift, evt);
>>  	evt->min_delta_ns = clockevent_delta2ns(4, evt);
>>  
>> -	local_clock_event = evt;
>> -
>> -	gic_enable_ppi(clock->irq.irq);
>> +	res = git_request_ppi(evt->irq, msm_timer_interrupt, evt);
> 
> Typo, should be gic_request_ppi.

Doh... Thanks for noticing this.

	M.
-- 
Jazz is not dead. It just smells funny...
