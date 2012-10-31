From: gautamvivek1987@gmail.com (Vivek Gautam)
Date: Wed, 31 Oct 2012 11:17:29 +0530
Subject: [PATCH] ARM: EXYNOS5: Remove wrongly placed usb2.0 PHY_CFG
 definition from PMU_REG
In-Reply-To: <003b01cda5f8$f84e35c0$e8eaa140$%han@samsung.com>
References: <1349443590-29901-1-git-send-email-gautam.vivek@samsung.com>
 <003b01cda5f8$f84e35c0$e8eaa140$%han@samsung.com>
Message-ID: <CAFp+6iG3389wDS8TQjLYooUTNCJjRWWuvSywOP-g8u5dJO3Zhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Tue, Oct 9, 2012 at 2:04 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> On Friday, October 05, 2012 10:27 PM Vivek Gautam wrote
>>
>> EXYNOS5_USB_CFG macro should actually point to USB20PHY_CFG
>> system register (base addr + 0x230). It's wrongly placed in regs-pmu.
>> Actual register at offset 0x230 in PMU is SEQ_TRANSITION4.
>>
>> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
>
> As you mentioned, this definition is wrong.
> So, it should be removed.
>
> Reviewed-by: Jingoo Han <jg1.han@samsung.com>
>
>
>> ---
>>  arch/arm/mach-exynos/include/mach/regs-pmu.h |    2 --
>>  1 files changed, 0 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/include/mach/regs-pmu.h b/arch/arm/mach-exynos/include/mach/regs-pmu.h
>> index d4e392b..70b2795 100644
>> --- a/arch/arm/mach-exynos/include/mach/regs-pmu.h
>> +++ b/arch/arm/mach-exynos/include/mach/regs-pmu.h
>> @@ -230,8 +230,6 @@
>>
>>  /* For EXYNOS5 */
>>
>> -#define EXYNOS5_USB_CFG                                              S5P_PMUREG(0x0230)
>> -

Any thoughts about this please.

>>  #define EXYNOS5_AUTO_WDTRESET_DISABLE                                S5P_PMUREG(0x0408)
>>  #define EXYNOS5_MASK_WDTRESET_REQUEST                                S5P_PMUREG(0x040C)
>>
>> --
>> 1.7.6.5
>>




-- 
Thanks & Regards
Vivek
