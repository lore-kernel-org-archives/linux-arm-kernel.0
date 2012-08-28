From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 28 Aug 2012 10:32:11 +0530
Subject: [PATCH v3 2/3] ARM: Exynos5: Add AUXDATA support for MSHC
 controllers
In-Reply-To: <503BFEA4.1070601@samsung.com>
References: <1345982371-26483-1-git-send-email-thomas.abraham@linaro.org>
 <1345982371-26483-3-git-send-email-thomas.abraham@linaro.org>
 <503BFEA4.1070601@samsung.com>
Message-ID: <CAJuYYwSxro48mY4jZj7ZJhW+4ncDCe=id17PdFOf7ypRGcuKmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 August 2012 04:41, Kukjin Kim <kgene.kim@samsung.com> wrote:
> On 08/26/12 04:59, Thomas Abraham wrote:
>>
>> Add entries if MSHC controllers in AUXDATA table for correct device name
>> initialization.
>>
>> Signed-off-by: Abhilash Kesavan<a.kesavan@samsung.com>
>> Signed-off-by: Thomas Abraham<thomas.abraham@linaro.org>
>> ---
>>   arch/arm/mach-exynos/include/mach/map.h |    1 +
>>   arch/arm/mach-exynos/mach-exynos5-dt.c  |    8 ++++++++
>>   2 files changed, 9 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/include/mach/map.h
>> b/arch/arm/mach-exynos/include/mach/map.h
>> index 9d1f3ac..5b0ee41 100644
>> --- a/arch/arm/mach-exynos/include/mach/map.h
>> +++ b/arch/arm/mach-exynos/include/mach/map.h
>> @@ -172,6 +172,7 @@
>>
>>   #define EXYNOS4_PA_HSMMC(x)           (0x12510000 + ((x) * 0x10000))
>>   #define EXYNOS4_PA_DWMCI              0x12550000
>> +#define EXYNOS5_PA_DWMCI(x)            (0x12200000 + ((x) * 0x10000))
>
>
> Just, how about EXYNOS5_PA_DWMMC0, EXYNOS5_PA_DWMMC1, ... EXYNOS_PA_DWMMC3?

Ok.

>
> And if the addresses are different on other EXYNOS5 SoC, how do we handle it
> for auxdata?

I hope that does not happen. So do you suggest that I change this to
EYNOS5250_PA_DWMMC0 ?

>
>
>>
>>   #define EXYNOS4_PA_HSOTG              0x12480000
>>   #define EXYNOS4_PA_USB_HSPHY          0x125B0000
>> diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c
>> b/arch/arm/mach-exynos/mach-exynos5-dt.c
>> index ef770bc..4257cc1 100644
>> --- a/arch/arm/mach-exynos/mach-exynos5-dt.c
>> +++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
>> @@ -47,6 +47,14 @@ static const struct of_dev_auxdata
>> exynos5250_auxdata_lookup[] __initconst = {
>>                                 "s3c2440-i2c.0", NULL),
>>         OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(1),
>>                                 "s3c2440-i2c.1", NULL),
>> +       OF_DEV_AUXDATA("samsung,exynos5250-dw-mshc", EXYNOS5_PA_DWMCI(0),
>
>
> As I commented, how about just 'samsung,dw-mmc'? but I'm not sure.

The dw-mmc controllers on Exynos 4210/4412/5250 have incremental
features. So different compatible strings are required to identify the
type of the controller.

Thanks for reviewing this patch series.

Regards,
Thomas.
