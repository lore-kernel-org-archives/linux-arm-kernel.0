From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 29 Aug 2012 17:37:13 +0530
Subject: [PATCH] ARM: EXYNOS: Add clocks for EXYNOS Audio Subsystem.
In-Reply-To: <CAAgF-Bdp817_RD3n6Sdo9zi=OrB4-Uiu5PDt4UB1BL-f0M4aJg@mail.gmail.com>
References: <1343218056-30432-1-git-send-email-padma.v@samsung.com>
 <031501cd6f98$dd67c550$98374ff0$%kim@samsung.com>
 <CAAgF-Bdp817_RD3n6Sdo9zi=OrB4-Uiu5PDt4UB1BL-f0M4aJg@mail.gmail.com>
Message-ID: <503E05F1.8050903@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2012 06:39 PM, Padma Venkat wrote:
> Hi,
> 
> On Wed, Aug 1, 2012 at 9:21 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> Padmavathi Venna wrote:
>>>
>>> Audiocdclk frequency is 16.9344MHz in SMDK5250 and this clock is
>>> board specific. So this patch adds a function to set the required
>>> audio codec clk frequency from machine file.
>>>
>>> This patch also adds all the required clock instances for audio
>>> subsystem and adds the clock alias names for i2sclk and busclk.
>>>
>>> Signed-off-by: Taylor Hutt <thutt@chromium.org>
>>> Signed-off-by: sangsu4u.park <sangsu4u.park@samsung.com>
>>> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
>>> ---
>>>  arch/arm/mach-exynos/clock-exynos5.c           |  129
>>> ++++++++++++++++++++++++
>>>  arch/arm/mach-exynos/common.h                  |    1 +
>>>  arch/arm/mach-exynos/include/mach/regs-audss.h |   12 ++
>>>  arch/arm/mach-exynos/mach-exynos5-dt.c         |    1 +
>>>  4 files changed, 143 insertions(+), 0 deletions(-)
>>>

[...]

>>> --- a/arch/arm/mach-exynos/mach-exynos5-dt.c
>>> +++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
>>> @@ -69,6 +69,7 @@ static void __init exynos5250_dt_machine_init(void)
>>>  {
>>>       of_platform_populate(NULL, of_default_bus_match_table,
>>>                               exynos5250_auxdata_lookup, NULL);
>>> +     exynos5_set_audiocdclk_rate(16934400);
>>
>> As you commented, the value of clock can be changed according to the board,
>> and this file, mach-exynos5-dt.c is not only for smdk5250, now there is no
>> board for exynos5250 though.
> Please suggest me some file where I can call this function then.
>>

Will it be a good idea to split this into two patches, one adding basic
audio subsystem defines and another one adding specific support for EXYNOS5?


>> [...]
>>
>> Thanks.
>>
>> Best regards,
>> Kgene.
> 
> Thanks for your review.
> 
> Best Regards
> Padma
>> --
>> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
>> SW Solution Development Team, Samsung Electronics Co., Ltd.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Tushar Behera
