From: dave.long@linaro.org (David Long)
Date: Sun, 03 Nov 2013 22:24:51 -0500
Subject: [PATCH v2 04/13] uprobes: allow arch-specific initialization
In-Reply-To: <20131101135247.GA16509@redhat.com>
References: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
 <1381871068-27660-5-git-send-email-dave.long@linaro.org>
 <20131019164223.GB7837@redhat.com> <52672484.9010201@linaro.org>
 <20131028185818.GB12863@redhat.com> <5272A45B.20507@linaro.org>
 <20131101135247.GA16509@redhat.com>
Message-ID: <52771383.5090907@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/13 09:52, Oleg Nesterov wrote:
> On 10/31, David Long wrote:
>> On 10/28/13 14:58, Oleg Nesterov wrote:
>>> On 10/22, David Long wrote:
>>> I simply do not understand why uprobes.c uses module_init/module_exit,
>>> it can't be compiled as a module.
>>
>> I guess that makes sense, assuming it can never be made a module.  I saw
>> you recent commit for this.
>>
>>> I think that module_exit/exit_uprobes should be killed, and module_init()
>>> should be turned into __initcall(). uprobes-arm.c can have another one.
>>>
>>
>> I will see if I can make this work.
>
> If this can't work, then we need the new hook (this patch). But in this
> case please update the changelog to explain the reason.
>
>> Right now the arch-specific
>> initialization call is done in the middle of the generic initialization
>> code, but I don't know that it *has* to be that way.  I have some
>> concern too about getting the order right, since these are built from
>> different makefiles.
>
> Not sure I understand... But grep shows a lot of core_initcall()'s in
> arch/arm/ which do register_undef_hook(). And I guess you can use any
> initcall level.

Just to close on this, I implemented your suggested __initcall change 
and it tested out fine.

-dl
