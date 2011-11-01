From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 01 Nov 2011 14:29:00 +0000
Subject: [RFC] Shrink sched_clock some more
In-Reply-To: <4EAAF5AE.6090300@codeaurora.org>
References: <20110922153611.GC8072@n2100.arm.linux.org.uk>
	<4E7C48E2.5040907@arm.com> <4EAAF5AE.6090300@codeaurora.org>
Message-ID: <4EB0022C.7080109@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/10/11 19:34, Stephen Boyd wrote:
> On 09/23/11 01:52, Marc Zyngier wrote:
>> On 22/09/11 16:36, Russell King - ARM Linux wrote:
>>> ... by getting rid of the fixed-constant optimization, and moving the
>>> update code into arch/arm/kernel/sched_clock.c.
>>>
>>> Platforms now only have to supply a function to read the sched_clock
>>> register, and some basic information such as the number of significant
>>> bits and the tick rate.
>> This looks similar to a patch I posted a while ago:
>> http://patchwork.ozlabs.org/patch/112318/
>>
>>
> 
> Can we get one of these two patches merged next merge window? I'd like
> to add sched_clock support to MSM and building on top of this patch is
> easier than the other way around.

I'm happy either way. The only problem I can see with Russell's patch is
the lack of support for platforms that do not actually implement a
sched_clock_read() function.

I've worked around this by having a default jiffy based read function,
but there is probably other, better solutions.

	M.
-- 
Jazz is not dead. It just smells funny...
