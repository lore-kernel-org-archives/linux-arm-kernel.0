From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 04 Jul 2014 21:46:30 +0200
Subject: [PATCH 2/3] clocksource: add device-tree support for PXA timer
In-Reply-To: <53B6471D.3010001@linaro.org> (Daniel Lezcano's message of "Fri,
 04 Jul 2014 08:18:05 +0200")
References: <1403388588-11956-1-git-send-email-robert.jarzmik@free.fr>
 <1403388588-11956-2-git-send-email-robert.jarzmik@free.fr>
 <53B5470D.4070009@linaro.org> <87tx6ynybb.fsf@free.fr>
 <53B6471D.3010001@linaro.org>
Message-ID: <874mywoqjt.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

>> Good question.
>>
>> Maybe not, I followed the same rationale as in orion-timer, which is :
>>   - as this timer is the only possible timer for PXA boards, and because without
>>   it the kernel boot will stall (scheduling will be blocked), it's better to
>>   panic early that to remain stalled.
>
> There isn't the arm global timer ?
Nope, it's for Cortex-A9 AFAIK, and my poor platform is an old ARMv5 SoC.

>
>> Isn't this a good approach ?
>
> I suppose we can live with that. IMO, the right fix would be in clksrc-of to
> pr_crit a message when an initialization fails. But that means to change all the
> init functions for all drivers which is out of the scope of this patchset.
OK, you convinced me. I'll trade the panic() for a pr_crit(). Good idea, maybe
it will trigger a quest of a white knight for the other drivers :)

Cheers.

-- 
Robert
