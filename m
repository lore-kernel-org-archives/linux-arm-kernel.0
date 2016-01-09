From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sat, 9 Jan 2016 11:46:12 +0900
Subject: [PATCH 2/2] ARM: exynos_defconfig: Enable s5p-secss driver
In-Reply-To: <568FD733.8030601@osg.samsung.com>
References: <1452132905-8587-1-git-send-email-k.kozlowski@samsung.com>
 <1452132905-8587-2-git-send-email-k.kozlowski@samsung.com>
 <568FD733.8030601@osg.samsung.com>
Message-ID: <CAJKOXPdie=mAPFxdnn_Ue+kNVTKQ1bFJigti35JMz7hmkYJ9cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-01-09 0:35 GMT+09:00 Javier Martinez Canillas <javier@osg.samsung.com>:
> Hello Krzysztof,
>
> On 01/06/2016 11:15 PM, Krzysztof Kozlowski wrote:
>> The Exynos SoC provides a Security SubSystem block for accelerating some
>> cryptographic operations. Enable the driver for it - s5p-secss to
>> utilize the hardware acceleration.
>>
>> Currently the s5p-secss driver supports AES in CBC and ECB modes.
>> However on Odroid XU4 (Exynos5422) and Trats2 (Exynos4412) boards this
>> change introduces one booting error:
>>
>>       alg: skcipher: encryption failed on chunk test 1 for ecb-aes-s5p: ret=22
>>
>> The cbc-aes-s5p properly registers itself and passes self-tests.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
>>  arch/arm/configs/exynos_defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
>> index 0aee1e035be9..c47c7e069873 100644
>> --- a/arch/arm/configs/exynos_defconfig
>> +++ b/arch/arm/configs/exynos_defconfig
>> @@ -240,6 +240,7 @@ CONFIG_DEBUG_RT_MUTEXES=y
>>  CONFIG_DEBUG_SPINLOCK=y
>>  CONFIG_DEBUG_MUTEXES=y
>>  CONFIG_DEBUG_USER=y
>> +CONFIG_CRYPTO_DEV_S5P=y
>
> I noticed that this is not enabled in multi_v7_defconfig.
> Are you planing to do it as well?

Thanks for feedback and review. I noticed that as well but I am not
convinced because one of two of supported algorithms fails the
tests... which makes 50% of driver non-working. :) Maybe it is
harmless - just pollutes the dmesg... Maybe after fixing it.

Best regards,
Krzysztof
