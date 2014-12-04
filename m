From: dave.long@linaro.org (David Long)
Date: Wed, 03 Dec 2014 19:02:57 -0500
Subject: [PATCH v3 0/5] ARM64: Add kernel probes(Kprobes) support
In-Reply-To: <547F94B0.1000902@linaro.org>
References: <1416292375-29560-1-git-send-email-dave.long@linaro.org>
 <20141120135851.GA32528@linaro.org> <54759041.9080105@hitachi.com>
 <20141126100325.GA9157@linaro.org> <5476120D.9030703@linaro.org>
 <CAPvkgC3eVOZEn79C9PC9c7TqC_-yCtDhw5LL6ZWUJxr+oQFaow@mail.gmail.com>
 <5476BFB4.2020705@hitachi.com>
 <CAPvkgC0ELPPWfa-8kQ4H_e_O5G1ER4KEKuSWLxh_u-VZgh7W6A@mail.gmail.com>
 <547C36DB.7060903@hitachi.com> <547F242D.1060705@redhat.com>
 <547F94B0.1000902@linaro.org>
Message-ID: <547FA4B1.6050200@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/14 17:54, David Long wrote:
> On 12/03/14 09:54, William Cohen wrote:
>> On 12/01/2014 04:37 AM, Masami Hiramatsu wrote:
>>> (2014/11/29 1:01), Steve Capper wrote:

[...]

>>>> That would explain why the state of play of the interrupts is in an
>>>> unexpected state in the crash I reported:
>>>> "The point of failure in the panic was:
>>>> fs/buffer.c:1257
>>>>
>>>> static inline void check_irqs_on(void)
>>>> {
>>>> #ifdef irqs_disabled
>>>>          BUG_ON(irqs_disabled());
>>>> #endif
>>>> }
>>>> "
>>>>
>>>> This is all new to me so I'm still at the head-scratching stage.
>>>
>>> Ah, I see.
>>>
>>> Thank you,
>>>
>>>>
>>>> David,
>>>> Does the above make sense to you? Have you managed to reproduce the
>>>> crash I get?
>>>>
>>>> Cheers,
>>>> --
>>>> Steve
>
> I have easily produced a crash although it doesn't look to me like the
> same one.  I'm getting a NULL pointer dereference.  The PMU stuff (used
> by perf record|stat -e) should be quite independent of kprobes though.
>
> -dl
>

Oops, never mind the above bit.  I see this is not PMU-related, but use 
of kprobes through perf.  My bad.

-dl
