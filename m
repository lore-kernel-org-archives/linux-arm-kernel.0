From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 11 Sep 2012 11:32:11 +0200
Subject: [PATCH] ARM: EXYNOS5: Add bus clock and set parent clock for FIMD
In-Reply-To: <CAL1wa8f1=hVMYrw2qdnQK5wFh8CtLxjP79+8POOG7HHqOBU5yA@mail.gmail.com>
References: <1347307866-30641-1-git-send-email-l.krishna@samsung.com>
 <000101cd8fb3$90d10db0$b2732910$%han@samsung.com>
 <CAL1wa8f1=hVMYrw2qdnQK5wFh8CtLxjP79+8POOG7HHqOBU5yA@mail.gmail.com>
Message-ID: <504F051B.5070903@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2012 11:19 AM, Leela Krishna Amudala wrote:
>>> diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
>>> index 774533c..f1281cf 100644
>>> --- a/arch/arm/mach-exynos/clock-exynos5.c
>>> +++ b/arch/arm/mach-exynos/clock-exynos5.c
>>> @@ -891,6 +891,13 @@ static struct clk exynos5_clk_mdma1 = {
>>>       .ctrlbit        = (1 << 4),
>>>  };
>>>
>>> +static struct clk exynos5_clk_fimd = {
>>> +     .name           = "fimd",
>>> +     .devname        = "exynos5-fb",
>>
>>
>> Replace 'exynos5-fb' with 'exynos5-fb.1', as exynos4 fimd uses exynos4-fb.0
>> as devname. Exynos5 can use fimd0 or fimd1. Also, Exynos5250 uses fimd1.
>>
>>
> Currently s3c-fb driver using "exynos5-fb" as device name, hence used
> the same name in the clock.
> This code is tested with both drm-fimd and s3c-fb fimd and it is
> working fine showing the display on LCD.
> If I change the device name in clock file then I have to change it in
> s3c-fb driver also.
> So I feel it is better to keep the name as "exynos5-fb" in clock file
> instead of changing in the driver.

Yeah, makes sense. We can always add a clkdev entry with CLKDEV_INIT()
if driver needs it. There is so much confusion now with having device name
associated with platform clock name. It should be possible to freely define
clock connection id and a platform clock association, not at the platform
clock definition.

I guess we can now clean all this up only during conversion to common clock
framework.


Regards,
-- 
Sylwester Nawrocki
Samsung Poland R&D Center
