From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sat, 11 May 2013 13:42:11 +0200
Subject: [PATCH V2 1/3] clk: samsung: register audio subsystem clocks
 using common clock framework
In-Reply-To: <CAAgF-BfeCZn8-_W-QxXw1QhU-Day-TEMtApiykw1mr7_aA=qTQ@mail.gmail.com>
References: <1367909016-19657-1-git-send-email-padma.v@samsung.com>
 <1367909016-19657-2-git-send-email-padma.v@samsung.com>
 <1730722.Al2EYiRntt@flatron>
 <CAAgF-BfeCZn8-_W-QxXw1QhU-Day-TEMtApiykw1mr7_aA=qTQ@mail.gmail.com>
Message-ID: <518E2E93.7030104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/11/2013 12:13 PM, Padma Venkat wrote:
>>> +CLK_OF_DECLARE(exynos4210_audss_clk, "samsung,exynos4210-audss-clock",
>>> >>  +             samsung_audss_clk_init);
>>> >>  +CLK_OF_DECLARE(exynos5250_audss_clk, "samsung,exynos5250-audss-clock",
>>> >>  +             samsung_audss_clk_init);
>> >
>> >  Also if both Exynos4210 and Exynos5250 have exactly the same audss clock
>> >  layout, there is no reason to have two compatibles for them - the
>> >  convention is that just the first model that had this hardware is enough -
>> >  in this case Exynos4210.
>> >
>> >  Having two different compatibles suggests that those two SoCs differ in a
>> >  way that needs special handling, which is misleading, based on the fact
>> >  that there is no such special handling in the driver.
>
> There is only one difference between Exynos4 and Exynos5 is bit 1 of
> CLK_GATE register where in Exynos5 it is reserved and Exynos4 it is
> gate to IntMEM. I am not sure if we use this bit some where? So is it
> okey to have same compatible with this diff?

I think such difference warrants separate compatible properties, as 
Exynos5250
seems to be not compatible with Exynos4210 in that case. Reserved bits 
should
be left untouched.

I wouldn't be surprised to see more differences we might be overlooking 
now.
IMHO it's better to be save than sorry, keeping both 'compatible' 
strings as
they are now.

Regards,
Sylwester
