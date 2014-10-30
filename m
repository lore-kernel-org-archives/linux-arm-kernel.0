From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 30 Oct 2014 10:15:19 +0100
Subject: [PATCH] arm64: KVM: fix unmapping with 48-bit VAs
In-Reply-To: <54520027.5070002@arm.com>
References: <1414525005-21080-1-git-send-email-mark.rutland@arm.com>
 <5450C3F1.80400@arm.com> <20141030090051.GA14686@cbox>
 <54520027.5070002@arm.com>
Message-ID: <CAMJs5B-i952jh-0Wgu8tpkNVS2JHp85KPFzcR0tacgfq8oH2AA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 10:08 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 30/10/14 09:00, Christoffer Dall wrote:
>> On Wed, Oct 29, 2014 at 10:39:45AM +0000, Marc Zyngier wrote:
>>> Hi Mark,
>>>
>>> On 28/10/14 19:36, Mark Rutland wrote:
>>>> Hi All,
>>>>
>>>> I'm not at all familiar with this code, so my analysis below might be off. Does
>>>> this look right or am I just masking a more fundamental issue?
>>>>
>>>> I've given this a go with 4KiB pages on Juno with {39,48}-bit VAs and the
>>>> system seems to boot fine.
>>>
>>> Thanks for looking into this.
>>>
>>
>> yeah, sorry for missing this!
>>
>> [...]
>>
>>>
>>> Looks good to me!
>>>
>>> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>>>
>>> Christoffer, if you're OK with that one, I'll queue it up for the next -rc.
>>>
>> Yup (for the record we're not breaking anything because 48 bit VA still
>> depends on broken, right?):
>
> Since 04f905a (arm64: Allow 48-bits VA space without ARM_SMMU), we can
> select 48bit VA if the SMMU is not selected.
>
Did Catlin merge this separately or did I accidentally do that?  I
thought we were holding off on that until we had done more testing...

-Christoffer
