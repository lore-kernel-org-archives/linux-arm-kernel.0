From: linux.amoon@gmail.com (Anand Moon)
Date: Fri, 8 May 2015 09:31:43 +0530
Subject: [PATCH] clk samsung exynos5420 add CLK_RECALC_NEW_RATES flag to
 mout_apll and mout_kpll clock.
In-Reply-To: <CAJKOXPcCc8j=i5FPdF62bGKar74+4U=C9BPN9ar2j52Y8dSMwA@mail.gmail.com>
References: <1431020935-5025-1-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPcCc8j=i5FPdF62bGKar74+4U=C9BPN9ar2j52Y8dSMwA@mail.gmail.com>
Message-ID: <CANAwSgT8aa5svHgLbkNkSPXWT_hLez8e4cBws2ajEB9p56WHFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krysztof,

Actually the patch is based on https://lkml.org/lkml/2015/4/3/389
I don't know how to measure the energy consumption when compared to
cpufreq-exynos.

I will update the commit log and resend it with you review.

-Anand Moon




On 8 May 2015 at 05:44, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> 2015-05-08 2:48 GMT+09:00 Anand Moon <linux.amoon@gmail.com>:
>> Addition of CLK_RECALC_NEW_RATES flag to support Exynos5 cpu clk so that
>> correct divider values are re-calculated after both pre/post
>> clock notifiers had run for for mout_apll clock and mout_kpll clock.
> s/for for/for/
>
> Could you precise in commit message the observational effects
> *without* this patch? In other words: what is fixed? The divider will
> have incorrect values?
>
>>
>> Depend on https://lkml.org/lkml/2015/4/3/388
>>
>> Tested on OdroidXU3 Board.
>
> Thanks for providing this information. However
> 1. Patch dependency should not be part of commit message, It simply
> won't provide any meaningful information when they are merged.
> 2. Similarly testing platform also is not always put in commit message.
>
> So just put them after separator (triple-dash).
>
> After fixing the commit message:
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>
> Best regards,
> Krzysztof
