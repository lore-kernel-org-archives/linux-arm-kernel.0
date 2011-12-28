From: snjw23@gmail.com (Sylwester Nawrocki)
Date: Wed, 28 Dec 2011 12:09:07 +0100
Subject: [PATCH 2/2] ARM: Exynos: Hook up power domains to generic power
 domain infrastructure
In-Reply-To: <CAJuYYwTPqCdgzK+bcikNiowHxq33yAuf6B695ZZfCp2pYooxEw@mail.gmail.com>
References: <1323704789-23923-1-git-send-email-thomas.abraham@linaro.org>	<1323704789-23923-2-git-send-email-thomas.abraham@linaro.org>	<1323704789-23923-3-git-send-email-thomas.abraham@linaro.org>	<4EFA5154.9060606@gmail.com>
 <CAJuYYwTPqCdgzK+bcikNiowHxq33yAuf6B695ZZfCp2pYooxEw@mail.gmail.com>
Message-ID: <4EFAF8D3.9050204@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 12/28/2011 06:25 AM, Thomas Abraham wrote:
>>> +
>>> +static struct exynos4_pm_domain exynos4_pd_gps = {
>>> +     .base = (void __iomem *)S5P_PMU_GPS_CONF,
>>> +     .name = "pd-gps",
>>> +     .pd = {
>>> +             .power_off = exynos4_pd_power_off,
>>> +             .power_on = exynos4_pd_power_on,
>>> +     },
>>> +};
>>
>> I'm not sure if arch/arm/mach-exynos/pm.c is the right place to add this.
>> IMHO it would be much better to put PD in separate file, pm-runtime.c
>> or something like this.
> 
> Ok. I will move this to a new file pm-runtime.c.

Thanks.

>> Can we assume various exynos versions will have same S5P_PMU_*_CONF
>> addresses? For old s3c64xx SoCs such assumption could be valid but I'm
>> a bit uncertain about Exynos series.
> 
> The addresses could be different, but it can be mapped to a
> S5P_PMU_*_CONF. Maybe I did not understand your question here.

I meant that for handling the newer SoCs (e.g. exynos5) at runtime we might need
to create new power domain definitions. That's why I suggested new file
for runtime PM. mach-shmobile has even separate compilation unit per SoC,
with register definitions put directly in C file. I'm not sure we need separate
pm-exynos4.c, pm-exynos5.c... For now your patch looks good.

--

Regards,
Sylwester
