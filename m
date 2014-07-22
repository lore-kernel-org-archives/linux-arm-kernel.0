From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 22 Jul 2014 19:27:08 +0200
Subject: [PATCH 2/2] arm: add early_ioremap support
In-Reply-To: <CAL_Jsq+hRYySuT_40iGVwe-8GYuPBmHy+GbqQ6T5HSCDfCSMQw@mail.gmail.com>
References: <1404898792-4201-1-git-send-email-leif.lindholm@linaro.org>
 <1404898792-4201-3-git-send-email-leif.lindholm@linaro.org>
 <53CE95C2.8090807@samsung.com>
 <CAL_Jsq+hRYySuT_40iGVwe-8GYuPBmHy+GbqQ6T5HSCDfCSMQw@mail.gmail.com>
Message-ID: <53CE9EEC.4080709@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.07.2014 19:11, Rob Herring wrote:
> On Tue, Jul 22, 2014 at 11:48 AM, Tomasz Figa <t.figa@samsung.com> wrote:
>> Hi Leif,
>>
>> On 09.07.2014 11:39, Leif Lindholm wrote:
>>> From: Mark Salter <msalter@redhat.com>
>>>
>>> This patch uses the generic early_ioremap code to implement
>>> early_ioremap for ARM. The ARM-specific bits come mostly from
>>> an earlier patch from Leif Lindholm <leif.lindholm@linaro.org>
>>> here:
>>>
>>>   https://lkml.org/lkml/2013/10/3/279
>>
>> [snip]
>>
>>> diff --git a/arch/arm/mm/early_ioremap.c b/arch/arm/mm/early_ioremap.c
>>> new file mode 100644
>>> index 0000000..1013109
>>> --- /dev/null
>>> +++ b/arch/arm/mm/early_ioremap.c
>>> @@ -0,0 +1,86 @@
>>> +/*
>>> + * early_ioremap() support for ARM
>>> + *
>>> + * Based on existing support in arch/x86/mm/ioremap.c
>>> + *
>>> + * Restrictions: currently only functional before paging_init()
>>
>> Uhm, that's bad... This would explain why my earlycon code generates a
>> fault as soon as something prints after paging_init(). I'd say this
>> feature would be much more useful if mappings were carried over
>> paging_init(), so that mapped devices are available later as well.
>>
>> I'll see if I can code this on top of your patch, but unfortunately it
>> might end up with -ENOTIME.
> 
> I have fixmap support that's needed for earlycon. Here is the branch:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git fixmap
> 
> It is based on an earlier version of patchset and not on the latest
> version from Leif. Unfortunately, I don't have more time to spend on
> it ATM.

Thanks Rob. I'll give it a try.

Best regards,
Tomasz
