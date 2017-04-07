From: andr2000@gmail.com (Oleksandr Andrushchenko)
Date: Fri, 7 Apr 2017 20:38:03 +0300
Subject: [PATCH v1] arm64: Add support for on-demand backtrace of other
 CPUs
In-Reply-To: <cc6f2535-fa37-1368-e14e-e76e086d4e28@linaro.org>
References: <1489735663-2091-1-git-send-email-andr2000@gmail.com>
 <1489735663-2091-2-git-send-email-andr2000@gmail.com>
 <20170407170203.GC20645@e104818-lin.cambridge.arm.com>
 <cc6f2535-fa37-1368-e14e-e76e086d4e28@linaro.org>
Message-ID: <f357ff0b-c0bf-94b4-133d-bf69f0a96264@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/2017 08:09 PM, Daniel Thompson wrote:
> On 07/04/17 18:02, Catalin Marinas wrote:
>> On Fri, Mar 17, 2017 at 09:27:43AM +0200, Oleksandr Andrushchenko wrote:
>>> From: Daniel Thompson <daniel.thompson@linaro.org>
>>>
>>> Currently arm64 has no implementation of 
>>> arch_trigger_cpumask_backtrace.
>>> The patch provides one using library code recently added by Russell 
>>> King
>>> for for the majority of the implementation. Currently this is realized
>>> using regular irqs but could, in the future, be implemented using
>>> NMI-like mechanisms.
>>>
>>> Note: There is a small (and nasty) change to the generic code to ensure
>>>       good stack traces. The generic code currently assumes that
>>>       show_regs() will include a stack trace but arch/arm64 does not do
>>>       this so we must add extra code here. Ideas on a better approach
>>>       here would be very welcome (is there any appetite to change arm64
>>>       show_regs() or should we just tease out the dump code into a
>>>       callback
>>
>> Please see this discussion here:
>>
>> http://lkml.kernel.org/r/20170323150357.GH9287 at leverpostej
>>
>> I'm not a ware of a follow up but if we change the arm64 show_regs() to
>> dump the stack, we no longer need the generic code hunk in your patch.
>
> Great. That hack did always irk me!
>
> I'll tidy it up the next time I push out the PMR interrupt masking 
> patch set.
>
> Is there any interest in taking the patch before that. I don't mind 
> separating it out... I'm just not sure how useful it is.
>
Yes, please, could you make it as a separate patch, so it gets in the 
tree faster?
As to if it is useful... It is. I am working on Xen hypervisor [1] and 
sometimes it is
sooo useful to see what all the cores do.

Thank you in advance,
Oleksandr

[1] https://www.xenproject.org/
