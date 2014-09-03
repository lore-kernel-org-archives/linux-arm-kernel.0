From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Wed, 3 Sep 2014 13:44:11 +0530
Subject: [PATCH 13/14] arm64: exynos7: Enable ARMv8 based Exynos7 (SoC)
 support
In-Reply-To: <20140827110927.GC7773@leverpostej>
References: <1409132660-1898-1-git-send-email-ch.naveen@samsung.com>
 <1409132660-1898-5-git-send-email-ch.naveen@samsung.com>
 <20140827110927.GC7773@leverpostej>
Message-ID: <CAHfPSqBDJwOtZhoS7OC1N72Sa=YgdZKcnw+mczCEmVTrYvUF4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 27 August 2014 16:39, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Wed, Aug 27, 2014 at 10:44:20AM +0100, Naveen Krishna Chatradhi wrote:
>> From: Alim Akhtar <alim.akhtar@samsung.com>
>>
>> This patch adds the necessary Kconfig entries to enable
>> support for the ARMv8 based Exynos7 SoC.
>>
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> ---
>>  arch/arm64/Kconfig |   17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index fd4e81a..d555558 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -134,6 +134,23 @@ source "kernel/Kconfig.freezer"
>>
>>  menu "Platform selection"
>>
>> +config ARCH_EXYNOS7
>> +     bool "ARMv8 based SAMSUNG EXYNOS7"
>> +     select HAVE_S3C2410_WATCHDOG if WATCHDOG
>> +     select CLKSRC_OF
>
> This seems to be implied by ARM_ARCH_TIMER in the core arm64 Kconfig, so
> I'm not sure this is necessary.

Ok.

>
>> +     select COMMON_CLK_SAMSUNG
>> +     select GPIOLIB
>
> You select ARCH_REQUIRE_GPIOLIB below, so is this necessary?

Yes, this is not required. Will remove.

>
>> +     select PINCTRL
>> +     select PINCTRL_EXYNOS
>> +     select RTC_CLASS
>> +     select HAVE_S3C_RTC
>> +     select GENERIC_GPIO
>> +     select ARCH_REQUIRE_GPIOLIB
>> +     select HAVE_CLK
>
> Isn't this selected already through the core arm64 Kconfig?
>
> It looks like we have COMMON_CLK, which selects CLKDEV_LOOKUP, which
> selects HAVE_CLK.

Ok.

>
>> +     select HAVE_SMP
>
> I may have missed something, but I didn't see any SMP support in this
> series.

As Catalin suggested, will remove this.

>
> Thanks,
> Mark.

Thanks for your comments.

-- 
Shine bright,
(: Nav :)
