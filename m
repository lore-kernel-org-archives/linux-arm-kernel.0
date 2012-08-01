From: padma.kvr@gmail.com (Padma Venkat)
Date: Wed, 1 Aug 2012 18:45:20 +0530
Subject: [PATCH] ARM: EXYNOS: Add static mapping for EXYNOS Audio Subsystem
In-Reply-To: <030e01cd6f95$68272ae0$387580a0$%kim@samsung.com>
References: <1343218009-30400-1-git-send-email-padma.v@samsung.com>
 <030e01cd6f95$68272ae0$387580a0$%kim@samsung.com>
Message-ID: <CAAgF-BcoSoUGjPaFaa2Jd=j+8DYSZk0u7dY65dBWzvnHF0fR9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 1, 2012 at 8:56 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Padmavathi Venna wrote:
>>
>> The CMU of EXYNOS can't control Audio Subsystem's clocks because
>> AUDSS SFRs aren't located in CMU. But AUDSS is a kind of CMU for
>> Audio Subsystem and need to use clock framework. This mapping
>> address will be used for AUDSS clock control.
>>
>> Signed-off-by: sangsu4u.park <sangsu4u.park@samsung.com>
>
> Maybe Sangsu Park?
>
>> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
>> ---
>>  arch/arm/mach-exynos/common.c                |    5 +++++
>>  arch/arm/mach-exynos/include/mach/map.h      |    1 +
>>  arch/arm/plat-samsung/include/plat/map-s5p.h |    2 ++
>>  3 files changed, 8 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
>> index 4eb39cd..4070c79 100644
>> --- a/arch/arm/mach-exynos/common.c
>> +++ b/arch/arm/mach-exynos/common.c
>> @@ -109,6 +109,11 @@ static struct map_desc exynos_iodesc[] __initdata = {
>>               .pfn            = __phys_to_pfn(EXYNOS_PA_CHIPID),
>>               .length         = SZ_4K,
>>               .type           = MT_DEVICE,
>> +     }, {
>> +             .virtual        = (unsigned long)S5P_VA_AUDSS,
>> +             .pfn            = __phys_to_pfn(EXYNOS_PA_AUDSS),
>> +             .length         = SZ_4K,
>> +             .type           = MT_DEVICE,
>>       },
>>  };
>>
>> diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-
>> exynos/include/mach/map.h
>> index 5cf7d91..9c044a0 100644
>> --- a/arch/arm/mach-exynos/include/mach/map.h
>> +++ b/arch/arm/mach-exynos/include/mach/map.h
>> @@ -39,6 +39,7 @@
>>
>>  #define EXYNOS4_PA_G2D                       0x12800000
>>
>> +#define EXYNOS_PA_AUDSS                      0x03810000
>>  #define EXYNOS_PA_I2S0                       0x03830000
>>  #define EXYNOS4_PA_I2S1                      0xE2100000
>>  #define EXYNOS4_PA_I2S2                      0xE2A00000
>> diff --git a/arch/arm/plat-samsung/include/plat/map-s5p.h b/arch/arm/plat-
>> samsung/include/plat/map-s5p.h
>> index c2d7bda..3558277 100644
>> --- a/arch/arm/plat-samsung/include/plat/map-s5p.h
>> +++ b/arch/arm/plat-samsung/include/plat/map-s5p.h
>> @@ -40,6 +40,8 @@
>>  #define S5P_VA_GIC_CPU               S3C_ADDR(0x02810000)
>>  #define S5P_VA_GIC_DIST              S3C_ADDR(0x02820000)
>>
>> +#define S5P_VA_AUDSS         S3C_ADDR(0x02910000)
>
> Is there any reason to use the offset, 0x02910000?
>
> [...]
>
> And I think, this patch should be patch-set with your '[PATCH] ARM: EXYNOS:
> Add clocks for EXYNOS Audio Subsystem.'
Okay. In the next version I will send it along with clock support for audio.
>
> Thanks.
>
> Best regards,
> Kgene.

Thanks&Regards
Padma
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
