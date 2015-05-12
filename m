From: slash.tmp@free.fr (Mason)
Date: Tue, 12 May 2015 16:41:53 +0200
Subject: High-resolution timers not supported when using smp_twd
 on Cortex A9
In-Reply-To: <554B2707.6010802@free.fr>
References: <554727A0.3040601@free.fr>
 <20150506111949.GP2067@n2100.arm.linux.org.uk> <554B2707.6010802@free.fr>
Message-ID: <55521131.5050804@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2015 10:49, Mason wrote:
> On 06/05/2015 13:19, Russell King - ARM Linux wrote:
>> On Mon, May 04, 2015 at 10:02:40AM +0200, Mason wrote:
>>> (The system's clocksource is a 27 MHz 32-bit counter.)
>>>
>>> If I remove the CLOCK_EVT_FEAT_C3STOP flag, then hrtimers are enabled,
>>> but I assume I would then run into problems in low-power mode, going by
>>> Russell's commit message.
>>
>> It seems that you've done the research, and judging from the question
>> you ask below, you already know the answer:
>>
>>> Do I have to use a platform-specific clockevent source if I want
>>> high-resolution timers on the system?
>>
>> Yes - because the TWD stops in low power modes, which makes it unsuitable
>> as a high-resolution timer.  These kinds of issues are annoying, but it's
>> the way things are.
> 
> Hello Russell and LAKML readers,
> 
> I did dig pretty deep while investigating the issue, but there are still
> some aspects of the problem that are not clear to me.
> 
> The most important is: what exactly is meant by "low power modes".
> Does the idle loop calling wfi send the system into low power mode?
> Are there several low power modes?
> How are these modes entered and exited?
> Is this documented in the ARM reference manual?
> or in the Cortex A9 technical manual?
> 
> The other thing I don't understand is: if the TWD stops in low power
> mode, then that means the system would not even receive the scheduling
> tick anymore? Wouldn't that break even coarse timers?
> 
> Does that mean using TWD as clockevent source is incompatible with
> CONFIG_HZ_PERIODIC=y?
> (So we must pick CONFIG_NO_HZ_IDLE=y or CONFIG_NO_HZ_FULL=y)
> 
> https://www.kernel.org/doc/Documentation/timers/NO_HZ.txt
> 
> High-resolution timers are a "nice-to-have" feature, but I
> think being able to use vanilla code is an overriding factor.
> I just wish there was a way to get hrtimers while using
> standard vanilla code :-)

Hello all,

Is there, perhaps, a better place to discuss these issues?
(IRC, web forum, other mailing list, Stack Overflow, ...)

Regards.
