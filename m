From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 22 Jan 2016 09:09:28 -0300
Subject: [PATCH v2 10/10] ARM: multi_v7_defconfig: Remove MAX77802 RTC
 Kconfig symbol
In-Reply-To: <56A1FD25.7020008@nvidia.com>
References: <1453407813-14646-1-git-send-email-javier@osg.samsung.com>
 <1453407813-14646-11-git-send-email-javier@osg.samsung.com>
 <56A1FD25.7020008@nvidia.com>
Message-ID: <56A21BF8.8000901@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Laxman,

On 01/22/2016 06:57 AM, Laxman Dewangan wrote:
>
> On Friday 22 January 2016 01:53 AM, Javier Martinez Canillas wrote:
>> The driver has been removed so the Kconfig symbol is not valid anymore.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>
>>
>> ---
>>
>> Changes in v2:
>> - Add Krzysztof Kozlowski's Reviewed-by tag to patch #10.
>>
>>   arch/arm/configs/multi_v7_defconfig | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> index 314f6be2dca2..bdb42c09332c 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>> @@ -664,7 +664,6 @@ CONFIG_RTC_DRV_MAX8907=y
>>   CONFIG_RTC_DRV_MAX8997=m
>>   CONFIG_RTC_DRV_MAX77686=y
>>   CONFIG_RTC_DRV_RK808=m
>> -CONFIG_RTC_DRV_MAX77802=m
>
> Do you need to make
>
> CONFIG_RTC_DRV_MAX77686=m
>

Yes we should, the RTC_DRV_MAX778686 Kconfig symbol was enabled in multi_v7
before the "build as much as possible as a module" policy was asked so got
enabled built-in. The RTC_DRV_MAX77802 was introduced later so it was asked
to be built as a module instead.

I think we could do that as a separate patch though, once this series land.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
