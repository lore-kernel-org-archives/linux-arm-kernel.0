From: amit.daniel@samsung.com (amit daniel kachhap)
Date: Tue, 18 Jun 2013 14:24:50 +0530
Subject: [PATCH v2 29/38] thermal: exynos: Support both Exynos4x12 SoCs
In-Reply-To: <51BF9D0A.6050706@ti.com>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
 <1371486863-12398-30-git-send-email-t.figa@samsung.com>
 <201306172159.15352.arnd@arndb.de> <51BF9D0A.6050706@ti.com>
Message-ID: <CADGdYn7NqywgfYFmwZHGLQi_mciJLbPGOwj2Jm2Zgbme9GGUUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eduardo,

On Tue, Jun 18, 2013 at 5:04 AM, Eduardo Valentin
<eduardo.valentin@ti.com> wrote:
> Arnd,
>
> On 17-06-2013 15:59, Arnd Bergmann wrote:
>> On Monday 17 June 2013, Tomasz Figa wrote:
>>> diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
>>> index 788b1dd..4cbe3ee 100644
>>> --- a/drivers/thermal/exynos_thermal.c
>>> +++ b/drivers/thermal/exynos_thermal.c
>>> @@ -817,7 +817,8 @@ static struct exynos_tmu_platform_data const exynos4210_default_tmu_data = {
>>>  #define EXYNOS4210_TMU_DRV_DATA (NULL)
>>>  #endif
>>>
>>> -#if defined(CONFIG_SOC_EXYNOS5250) || defined(CONFIG_SOC_EXYNOS4412)
>>> +#if defined(CONFIG_SOC_EXYNOS5250) || defined(CONFIG_SOC_EXYNOS4412) || \
>>> +       defined(CONFIG_SOC_EXYNOS4212)
>>>  static struct exynos_tmu_platform_data const exynos_default_tmu_data = {
>>>         .threshold_falling = 10,
>>>         .trigger_levels[0] = 85,
>>
>> The patch is correct, but generally speaking I think we should get away from
>> having the drivers get configured per SoC on such a fine-grained level.
>> Better make this driver (and others) always work on all exynos variants.
>
> Amit, correct if I am wrong, but:
>
> The driver will work on supported exynos variants. Those that have the
> need for thermal sensing. And each of them have specific thermal needs
> (trigger points, thresholds, etc). That is what this file tries to
> isolate. And there is specific data structures for each soc version.
Yes its correct that there may be some changes in data points for
different soc's. in the new re-structured code data is separated from
driver so more data can be added cleanly.

>
>
>>
>>       Arnd
>>
>>
>
>
> --
> You have got to be excited about what you are doing. (L. Lamport)
>
> Eduardo Valentin
>
