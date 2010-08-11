From: mcuos.com@gmail.com (Wan ZongShun)
Date: Wed, 11 Aug 2010 09:40:55 +0800
Subject: [rtc-linux] [PATCH 1/2] rtc: rtc-lpc32xx: Introduce RTC driver
	for the LPC32XX SoC
In-Reply-To: <083DF309106F364B939360100EC290F80AC6E5F76D@eu1rdcrdc1wx030.exi.nxp.com>
References: <1281370650-29520-1-git-send-email-wellsk40@gmail.com>
	<1281370650-29520-2-git-send-email-wellsk40@gmail.com>
	<AANLkTimAJj38R7KCfHusfsq+EXDd3fbAm=Az_Osqdgbz@mail.gmail.com>
	<083DF309106F364B939360100EC290F80AC6E5F76D@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <AANLkTinZBhZ8PRswbqUDyYzmDQ6Ccm96QAO8vpeWn+SD@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/11 Kevin Wells <kevin.wells@nxp.com>:
> Hi Zongshun,
>
> Thanks for helping review this.
>
>> Subject: Re: [rtc-linux] [PATCH 1/2] rtc: rtc-lpc32xx: Introduce RTC driver
>> for the LPC32XX SoC
>>
>> Hi Kevin ,
>>
>> This is really a natty rtc patch:).
>
> From the urban dictionary...
> "natty"
> 1) originating from rastafarian culture. meaning 'good','cool' and
> most importantly, 'elite'.
> 2) A slang for Natural Light beer, a favorite of poor college students
> the world over.
>

Hmm,I means the first, this patch looks very good to me. :)

> I hope it's the first one, but I guess the 2nd isn't that bad if
> you?re a college student o)
> I'll merge both patches into a single patch for v2 and repost in a
> few days.
>
>> > + ? ? ? /* Disable alarm during update */
>> > + ? ? ? tmp = rtc_readl(rtc, RTC_CTRL);
>> > + ? ? ? rtc_writel(rtc, RTC_CTRL, tmp & ~RTC_MATCH0_EN);
>> > +
>> > + ? ? ? rtc->alarm_enabled = wkalrm->enabled = 1;
>> > + ? ? ? if (wkalrm->enabled) {
>> > + ? ? ? ? ? ? ? rtc_writel(rtc, RTC_MATCH0, alarmsecs);
>> > + ? ? ? ? ? ? ? rtc_writel(rtc, RTC_INTSTAT, RTC_MATCH0_INT_STS);
>> > + ? ? ? ? ? ? ? rtc_writel(rtc, RTC_CTRL, tmp | RTC_MATCH0_EN);
>> > + ? ? ? }
>>
>> I think this 'wkalrm->enabled ' will always be set '1', so 'if'
>> condition will be alway true?
>
> Thanks for catching this. The '= 1' assignment shouldn't be there.
>



-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel at lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900 at googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com at gmail.com
