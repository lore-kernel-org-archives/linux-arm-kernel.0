From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Wed, 3 Sep 2014 13:13:21 +0530
Subject: [PATCH 08/14] i2c: exynos5: Add Kconfig dependencies
In-Reply-To: <20140828040311.GD4972@localhost>
References: <1409132740-1954-1-git-send-email-ch.naveen@samsung.com>
 <1409132740-1954-2-git-send-email-ch.naveen@samsung.com>
 <20140828040311.GD4972@localhost>
Message-ID: <CAHfPSqBTskQxC_HktLyPF=4cmmzZvVZO2u_Y4tXkftA1qtsR4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 28 August 2014 09:33, Olof Johansson <olof@lixom.net> wrote:
> On Wed, Aug 27, 2014 at 03:15:40PM +0530, Naveen Krishna Chatradhi wrote:
>> The i2c-exynos5.c driver can be reused for the HSI2C controller
>> on Exynos7 SoCs from Samsung.
>>
>> This patch adds the Kconfig dependency to choose i2c-exynos5.c
>> for CONFIG_ARCH_EXYNOS7.
>>
>> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>> To: linux-i2c at vger.kernel.org
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> ---
>>  drivers/i2c/busses/Kconfig |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index 2ac87fa..bd18fa6 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -465,7 +465,7 @@ config I2C_EG20T
>>
>>  config I2C_EXYNOS5
>>       tristate "Exynos5 high-speed I2C driver"
>> -     depends on ARCH_EXYNOS5 && OF
>> +     depends on (ARCH_EXYNOS5 || ARCH_EXYNOS7) && OF
>
> Ick, this will keep growing. Please use ARCH_EXYNOS instead. Yes,
> this means you need to add it to the arm64 Kconfig and select it from
> ARCH_EXYNOS7.

Ok, will repost with ARCH_EXYNOS. Thanks.

>
>
>
> -Olof

-- 
Shine bright,
(: Nav :)
