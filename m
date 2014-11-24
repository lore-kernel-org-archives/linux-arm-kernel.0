From: amit.daniel@samsung.com (amit daniel kachhap)
Date: Mon, 24 Nov 2014 07:46:08 +0530
Subject: [PATCH v5 1/2] clk: samsung: exynos5440: move restart code into
 clock driver
In-Reply-To: <02a801d005f9$45839030$d08ab090$@kernel.org>
References: <1416307650-15162-1-git-send-email-pankaj.dubey@samsung.com>
 <1416307650-15162-2-git-send-email-pankaj.dubey@samsung.com>
 <546B62F3.3030807@samsung.com>
 <000901d003aa$3490e8a0$9db2b9e0$@samsung.com>
 <546E2968.1070800@samsung.com> <546F1436.4020101@samsung.com>
 <02a801d005f9$45839030$d08ab090$@kernel.org>
Message-ID: <CADGdYn71_tnN+HPnuTvkHCpLun2yzy2m=A70iai0Jp0Bp8SayQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 22, 2014 at 7:38 AM, Kukjin Kim <kgene@kernel.org> wrote:
> Pankaj Dubey wrote:
>>
>> Hi Kukjin,
>>
> Hi,
>
>> On Thursday 20 November 2014 11:18 PM, Sylwester Nawrocki wrote:
>> > On 19/11/14 04:37, Pankaj Dubey wrote:
>> >>>>
>> >>>>>> +static int exynos5440_clk_restart_notify(struct notifier_block *this,
>> >>>>>> +              unsigned long code, void *unused)
>> >>>>>> +{
>> >>>>>> +      u32 val, status;
>> >>>>>> +
>> >>>>>> +      status = readl_relaxed(reg_base + 0xbc);
>> >>>>>> +      val = readl_relaxed(reg_base + 0xcc);
>> >>>>>> +      val = (val & 0xffff0000) | (status & 0xffff);
>> >>>>>> +      writel_relaxed(val, reg_base + 0xcc);
>> >>>>
>> >>>> Can we have macro definitions for these 0xcc, 0xbc address offsets ?
>> >>>> I must say I couldn't find them documented in any Exynos datasheet I've
>> >> got though.
>> >>>>
>> >>
>> >> I also wished this, but I could not find them documented.
>> >> So I tried to keep logic of original code as it is, just changed location.
>> >> I would also like to mention that I have not tested this on exynos5440 as I
>> >> do not have
>> >> one with me. I believe if it was working at its original place in
>> >> exynos_restart it should work
>> >> here also. Other patch (2/2) I have verified on Exynos3250 board and its
>> >> working well.
>> >
>> > I think it's best to merge both patches in that series through
>> > the arm-soc tree, since applying them not in order may cause some
>> > breakage. Thus I'd let Kukjin take this patch set into his tree.
>> >
>> > For both patches:
>> > Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> >
> Sylwester, thanks for your ack.
>
>>
>> Will you please take this series into your tree.
>>
> + Amit Daniel
>
> Yeah, this series looks good to me and I'm looking at this series with Amit's
> moving pmu.c into drivers/. Maybe I need to ask Amit to respin the series on
> top of this? If required, I'll reply.

I was ready to post pmu v4 version with Russell suggested changes so i
rebased and posted v4 series
on top of this 2 patch.

Regards,
Amit D
>
> Thanks,
> Kukjin
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
