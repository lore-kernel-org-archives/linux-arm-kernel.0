From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 10 Aug 2011 09:59:24 +0100
Subject: [RFC PATCH] ARM: sched_clock: allow sched_clock to be selected
	at runtime
In-Reply-To: <20110810085210.GC1831@n2100.arm.linux.org.uk>
References: <1312910015-20043-1-git-send-email-marc.zyngier@arm.com>
	<4E41A4A4.80000@gmail.com>
	<CAMPhdO8qCXrPN7ASo=Fhm+BQJN11NRy=kNPv8ySHMbd24df3Rw@mail.gmail.com>
	<4E424112.10804@arm.com>
	<20110810085210.GC1831@n2100.arm.linux.org.uk>
Message-ID: <4E42486C.5030605@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/11 09:52, Russell King - ARM Linux wrote:
> On Wed, Aug 10, 2011 at 09:28:02AM +0100, Marc Zyngier wrote:
>> I'd be all for that, and I've waited a long time (April?) before posting
>> that patch, hoping that a consensus would emerge on the clocksourse
>> patches.
>>
>> So far, nothing.
>>
>> We need a solution to this problem. I really don't care which patch gets
>> merged, so if someone thinks they can get the clocksource patches
>> further, then by all mean, please do it.
> 
> I'll say it again, because you seem to have missed it.  I don't think
> intimately tying sched_clock and clocksource stuff together is a good
> idea, especially as there's platforms where sched_clock is higher
> resolution than the clocksource.  Plus, if it really is the case that
> any clocksource can be used for sched_clock, then we wouldn't have
> sched_clock at all.
> 
> So no, I don't think tying the two together is a good idea.  Especially
> when it means that some platforms will end up with a lower resolution
> and/or slower implementation.

Fair enough. I'll carry on with my current patch then.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
