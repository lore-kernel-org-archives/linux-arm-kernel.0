From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 19 Dec 2011 12:45:09 +0800
Subject: [PATCH v3 2/4] ARM: pxa168: Add SDHCI support
In-Reply-To: <m2sjklfmuf.fsf@bob.laptop.org>
References: <87r51fwxgt.fsf@laptop.org>
 <1321849572-2944-1-git-send-email-tanmay.upadhyay@einfochips.com>
 <874nxkmaky.fsf@laptop.org> <m2sjklfmuf.fsf@bob.laptop.org>
Message-ID: <CAN1soZxmKct+qGUE2_W+FZufR+gcYZu6Dsj+TkJ06PaO8rV-TQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2011 at 7:15 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi Eric and Jason,
>
> On Thu, Dec 01 2011, Chris Ball wrote:
>> Hi Eric, Jason,
>>
>> Please could you ACK this patch if you agree with it, and I'll take it
>> and the rest of the series via the MMC tree? ?Thanks.
>
> Ping?
>
> Thanks,
>
> - Chris.
>
NACK.

>>> +/* Offset defined in arch/arm/mach-mmp/include/mach/regs-apmu.h are for MMP2
>>> + * PXA168 has different offset */
>>> +#undef APMU_SDH2
>>> +#undef APMU_SDH3
>>> +
>>> +#define APMU_SDH2   APMU_REG(0xe0)
>>> +#define APMU_SDH3   APMU_REG(0xe4)
>>> +

Please don't use #undef at here. If the register setting is different,
I prefer to use two different clk operations.
