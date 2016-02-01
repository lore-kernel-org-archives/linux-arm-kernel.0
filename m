From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Mon, 1 Feb 2016 12:09:56 -0300
Subject: [PATCH 1/2] clocksource/drivers/lpc32xx: Support periodic mode
In-Reply-To: <CAAEAJfAVTJm-PzhjkRmkdNG39sH7eHyEXaSX4q0=TCQ0468Heg@mail.gmail.com>
References: <1454136379-7517-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <CAGhQ9VxO7Rsus8Js_oZDBxWzEHuUHnRyoVTVmawbtXmK7tNMcw@mail.gmail.com>
 <CAAEAJfAVTJm-PzhjkRmkdNG39sH7eHyEXaSX4q0=TCQ0468Heg@mail.gmail.com>
Message-ID: <CAAEAJfD8LUV=t97RN3U4uqgzCLP89AQtHqBccKGd6-EskP9DOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 January 2016 at 17:07, Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
> On 30 January 2016 at 16:39, Joachim  Eastwood <manabian@gmail.com> wrote:
>> Hi Ezequiel,
>>
>> On 30 January 2016 at 07:46, Ezequiel Garcia
>> <ezequiel@vanguardiasur.com.ar> wrote:
>>> This commit adds the support for periodic mode. This is done by not
>>> setting the MR0S (Stop on TnMR0) bit on MCR, thus allowing
>>> interrupts to be periodically generated on MR0 matches.
>>>
>>> In order to do this, move the initial configuration that is specific to
>>> the one shot mode to clock_event_device.set_state_oneshot.
>>>
[...]
>
>>
>> I will look more closely at the new timer setup later.
>>
>> btw, didn't I look through a version of this you sent me privately
>> quite some time ago?
>> I think I had a comment about using TIMER_PR instead of TIMER_MR0
>> then. Unsure if that is still valid, though.
>>
>
> Ah, right. It was ages ago, and forgot your previous review. Sorry about that.
> Using TIMER_PR looks less invasive so I'll send a v2 using it instead.

Actually, using the prescale counter and MR0 = 1 resulted in exactly
half the number of interrupts that I expected (HZ / 2). Using this
patch, with PR=0 and MR0=ticks_per_jiggies, I can see HZ no. of
interrupts per sec.

Why did you choose to use the prescale in your oneshot implementation?
Did you test or measure the timer expire using the PR and MR0 = 1?

To be honest, I'm still trying to make some sense out of my results.
-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
