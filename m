From: padma.kvr@gmail.com (Padma Venkat)
Date: Wed, 1 Aug 2012 18:51:20 +0530
Subject: [PATCH] ARM: EXYNOS: Add I2S SFR base addresses
In-Reply-To: <030801cd6f92$55370570$ffa51050$%kim@samsung.com>
References: <0M7R00MY1GHTPK20@ms14.samsung.com>
 <030801cd6f92$55370570$ffa51050$%kim@samsung.com>
Message-ID: <CAAgF-Bd+R=a_AxE+CCBqT25Bzt5zMzqR0U3Jz60dRVO90MOcwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 1, 2012 at 8:34 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> PADMAVATHI VENNA wrote:
>
> Padma, don't post with html styled :(
Sorry for the inconvenience. I will take care.
>
> And you need to check the regarding addresses as per Sachin commented.
Okay.
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
> ------- Original Message -------
> Sender : Sachin Kamat<sachin.kamat@linaro.org>
> Date : Jul 26, 2012 13:41 (GMT+09:00)
> Title : Re: [PATCH] ARM: EXYNOS: Add I2S SFR base addresses
>
> On 25 July 2012 17:35, Padmavathi Venna wrote:
>> The base address of I2S 0 controller is similar in exynos4 and exynos5
>> platforms. So this patch defines a common macro for the I2S controller
>> 0 base address in both the platforms and use the same macro.
>>
>> This patch also defines the I2S controller 1,2 base addresses in exynos5
>> and correct the I2S controller 1 base address in exynos4
>>
>> Signed-off-by: Padmavathi Venna
>> ---
>>  arch/arm/mach-exynos/dev-audio.c        |    2 +-
>>  arch/arm/mach-exynos/include/mach/map.h |    6 ++++--
>>  2 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/dev-audio.c
> b/arch/arm/mach-exynos/dev-audio.c
>> index b33a5b6..5dbc9a2 100644
>> --- a/arch/arm/mach-exynos/dev-audio.c
>> +++ b/arch/arm/mach-exynos/dev-audio.c
>> @@ -62,7 +62,7 @@ static struct s3c_audio_pdata i2sv5_pdata = {
>>  };
>>
>>  static struct resource exynos4_i2s0_resource[] = {
>> -       [0] = DEFINE_RES_MEM(EXYNOS4_PA_I2S0, SZ_256),
>> +       [0] = DEFINE_RES_MEM(EXYNOS_PA_I2S0, SZ_256),
>>         [1] = DEFINE_RES_DMA(DMACH_I2S0_TX),
>>         [2] = DEFINE_RES_DMA(DMACH_I2S0_RX),
>>         [3] = DEFINE_RES_DMA(DMACH_I2S0S_TX),
>> diff --git a/arch/arm/mach-exynos/include/mach/map.h
> b/arch/arm/mach-exynos/include/mach/map.h
>> index c72b675..5cf7d91 100644
>> --- a/arch/arm/mach-exynos/include/mach/map.h
>> +++ b/arch/arm/mach-exynos/include/mach/map.h
>> @@ -39,9 +39,11 @@
>>
>>  #define EXYNOS4_PA_G2D                 0x12800000
>>
>> -#define EXYNOS4_PA_I2S0                        0x03830000
>> -#define EXYNOS4_PA_I2S1                        0xE3100000
>> +#define EXYNOS_PA_I2S0                 0x03830000
>> +#define EXYNOS4_PA_I2S1                        0xE2100000
>>  #define EXYNOS4_PA_I2S2                        0xE2A00000
>
> As per the TRM, these addresses (I2S1 and I2S2) are 0x13960000 and
> 0x13970000 respectively on Exynos4412 SoC.
> Please verify.
> I didn't verify Exynos4412 before. I will send a new patch for this.
>
>
>> +#define EXYNOS5_PA_I2S1                        0x12D60000
>> +#define EXYNOS5_PA_I2S2                        0x12D70000
>>
>>  #define EXYNOS4_PA_PCM0                        0x03840000
>>  #define EXYNOS4_PA_PCM1                        0x13980000
>> --
>> 1.7.4.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe
> linux-samsung-soc" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
