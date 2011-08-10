From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 10 Aug 2011 09:28:02 +0100
Subject: [RFC PATCH] ARM: sched_clock: allow sched_clock to be selected
	at runtime
In-Reply-To: <CAMPhdO8qCXrPN7ASo=Fhm+BQJN11NRy=kNPv8ySHMbd24df3Rw@mail.gmail.com>
References: <1312910015-20043-1-git-send-email-marc.zyngier@arm.com>
	<4E41A4A4.80000@gmail.com>
	<CAMPhdO8qCXrPN7ASo=Fhm+BQJN11NRy=kNPv8ySHMbd24df3Rw@mail.gmail.com>
Message-ID: <4E424112.10804@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/11 22:28, Eric Miao wrote:
> On Wed, Aug 10, 2011 at 5:20 AM, Rob Herring <robherring2@gmail.com> wrote:
>> On 08/09/2011 12:13 PM, Marc Zyngier wrote:
>>> sched_clock() is yet another blocker on the road to the single
>>> image. This patch implements an idea by Russell King:
>>>
>>> http://www.spinics.net/lists/linux-omap/msg49561.html
>>>
>>> Instead of asking the platform to implement both sched_clock()
>>> itself and the rollover callback, simply register a read()
>>> function, and let the ARM code care about sched_clock() itself,
>>> the conversion to ns and the rollover. sched_clock() uses
>>> this read() function as an indirection to the platform code.
>>>
>>> This allow some simplifications and possibly some footprint gain
>>> when multiple platforms are compiled in. Among the drawbacks,
>>> the removal of the *_fixed_sched_clock optimization which could
>>> negatively impact some platforms (sa1100, tegra, versatile
>>> and omap).
>>
>> There are similar patchsets that move sched_clock into clocksource code.
>> That seems like a cleaner approach to me.
>>
>> http://thread.gmane.org/gmane.linux.kernel/844872
>>
>> http://www.spinics.net/lists/arm-kernel/msg122716.html
> 
> +1, yeah would be better for clocksource to handle that if possible.

I'd be all for that, and I've waited a long time (April?) before posting
that patch, hoping that a consensus would emerge on the clocksourse
patches.

So far, nothing.

We need a solution to this problem. I really don't care which patch gets
merged, so if someone thinks they can get the clocksource patches
further, then by all mean, please do it.

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
