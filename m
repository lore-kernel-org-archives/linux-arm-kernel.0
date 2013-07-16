From: r.sricharan@ti.com (Sricharan R)
Date: Tue, 16 Jul 2013 10:51:44 +0530
Subject: [PATCH 8/8] ARM: DRA7: Kconfig: Increase the default gpio count
In-Reply-To: <51E29482.7060208@linaro.org>
References: <1373354873-12359-1-git-send-email-rnayak@ti.com>
 <1373354873-12359-9-git-send-email-rnayak@ti.com>
 <51E29482.7060208@linaro.org>
Message-ID: <51E4D868.8010609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 14 July 2013 05:37 PM, Kevin Hilman wrote:
> On 07/09/2013 08:27 AM, Rajendra Nayak wrote:
>> From: R Sricharan <r.sricharan@ti.com>
>>
>> DRA7xx has 8 GPIO banks so that there are 32x8 = 256 GPIOs.
>> In order for the gpiolib to detect and initialize these
>> additional GPIOs and other TWL GPIOs, ARCH_NR_GPIO is set
>> to 512 instead of present 256.
> nit: the patch itself doesn't change 256 to 512, but just adds another
> Kconfig default.
>
> Kevin
 hmm, ok. Will reword the $subject and commit accordingly

Regards,
 Sricharan
>> Signed-off-by: R Sricharan <r.sricharan@ti.com>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> ---
>>  arch/arm/Kconfig |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 5ef7af0..9faed52 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1599,7 +1599,7 @@ config LOCAL_TIMERS
>>  config ARCH_NR_GPIO
>>  	int
>>  	default 1024 if ARCH_SHMOBILE || ARCH_TEGRA
>> -	default 512 if SOC_OMAP5
>> +	default 512 if SOC_OMAP5 || SOC_DRA7XX
>>  	default 512 if ARCH_KEYSTONE
>>  	default 392 if ARCH_U8500
>>  	default 352 if ARCH_VT8500
>>
