From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 19 Dec 2011 13:02:08 +0800
Subject: [PATCH v3 2/4] ARM: pxa168: Add SDHCI support
In-Reply-To: <4EEEC3BF.6010708@einfochips.com>
References: <87r51fwxgt.fsf@laptop.org>
 <1321849572-2944-1-git-send-email-tanmay.upadhyay@einfochips.com>
 <874nxkmaky.fsf@laptop.org> <m2sjklfmuf.fsf@bob.laptop.org>
 <CAN1soZxmKct+qGUE2_W+FZufR+gcYZu6Dsj+TkJ06PaO8rV-TQ@mail.gmail.com>
 <4EEEC3BF.6010708@einfochips.com>
Message-ID: <CAN1soZxnSsZ8SDp=ueu0iMaz59pq7p09DoYD27qCridrrAkmuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 12:55 PM, Tanmay Upadhyay
<tanmay.upadhyay@einfochips.com> wrote:
>
>
> On Monday 19 December 2011 10:15 AM, Haojian Zhuang wrote:
>>
>> On Fri, Dec 16, 2011 at 7:15 AM, Chris Ball<cjb@laptop.org> ?wrote:
>>>
>>> Hi Eric and Jason,
>>>
>>> On Thu, Dec 01 2011, Chris Ball wrote:
>>>>
>>>> Hi Eric, Jason,
>>>>
>>>> Please could you ACK this patch if you agree with it, and I'll take it
>>>> and the rest of the series via the MMC tree? ?Thanks.
>>>
>>> Ping?
>>>
>>> Thanks,
>>>
>>> - Chris.
>>>
>> NACK.
>>
>>>>> +/* Offset defined in arch/arm/mach-mmp/include/mach/regs-apmu.h are
>>>>> for MMP2
>>>>> + * PXA168 has different offset */
>>>>> +#undef APMU_SDH2
>>>>> +#undef APMU_SDH3
>>>>> +
>>>>> +#define APMU_SDH2 ? APMU_REG(0xe0)
>>>>> +#define APMU_SDH3 ? APMU_REG(0xe4)
>>>>> +
>>
>> Please don't use #undef at here. If the register setting is different,
>> I prefer to use two different clk operations.
>>
>
> Sorry I couldn't get you. Could you please elaborate? Here regs-apmu.h
> defines clock register offsets. They are correct for MMP2, but not for
> PXA168. So I thought to correct them in a PXA168 specific file. Could you
> please point me a better way?
>
> Thanks,
>
> Tanmay

APMU_PXA168_SDH2
APMU_MMP2_SDH2

I think this is better.
