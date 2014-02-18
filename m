From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue, 18 Feb 2014 17:11:43 +0530
Subject: [PATCH v4 1/3] ARM: EXYNOS: initial board support for exynos5260
 SoC
In-Reply-To: <2203874.7pS2uKgoKp@wuerfel>
References: <1392721076-26630-1-git-send-email-rahul.sharma@samsung.com>
 <1392721076-26630-2-git-send-email-rahul.sharma@samsung.com>
 <2203874.7pS2uKgoKp@wuerfel>
Message-ID: <CAK9yfHwcteO78JG4OhRZtMcpAd-aN85sxqELJ3ZLW0D0PXoZ7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 18 February 2014 16:33, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 18 February 2014 16:27:54 Rahul Sharma wrote:
>> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
>> index 7654f19..1cc52c9 100644
>> --- a/arch/arm/mach-exynos/common.c
>> +++ b/arch/arm/mach-exynos/common.c
>> @@ -176,6 +176,15 @@ static struct map_desc exynos5250_iodesc[] __initdata = {
>>       },
>>  };
>>
>> +static struct map_desc exynos5260_iodesc[] __initdata = {
>> +     {
>> +             .virtual        = (unsigned long)S5P_VA_SYSRAM_NS,
>> +             .pfn            = __phys_to_pfn(EXYNOS5260_PA_SYSRAM_NS),
>> +             .length         = SZ_4K,
>> +             .type           = MT_DEVICE,
>> +     },
>> +};
>> +
>>  static struct map_desc exynos5_iodesc[] __initdata = {
>>       {
>>               .virtual        = (unsigned long)S3C_VA_SYS,
>> @@ -331,6 +340,8 @@ static void __init exynos_map_io(void)
>>               iotable_init(exynos4x12_iodesc, ARRAY_SIZE(exynos4x12_iodesc));
>>       if (soc_is_exynos5250())
>>               iotable_init(exynos5250_iodesc, ARRAY_SIZE(exynos5250_iodesc));
>> +     if (soc_is_exynos5260())
>> +             iotable_init(exynos5260_iodesc, ARRAY_SIZE(exynos5260_iodesc));
>>  }
>
> As I commented before, I think we really shouldn't do this any more: There
> is no excuse why you still need to add SoC specific code here. Please put
> the SYSRAM into DT and make a proper abstraction for it so you don't have
> to modify the kernel every time a new SoC variant comes out.

Do we have any bindings already defined for this kind of stuff or is
this implemented in
any other platform/architecture for reference?

-- 
With warm regards,
Sachin
