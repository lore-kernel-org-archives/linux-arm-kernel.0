From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 21 May 2014 13:50:06 +0530
Subject: [PATCH 2/3] ARM: EXYNOS: Enable multi-platform build support
In-Reply-To: <4352730.lnFJpo5XeV@wuerfel>
References: <1400655169-21683-1-git-send-email-sachin.kamat@linaro.org>
 <1400655169-21683-3-git-send-email-sachin.kamat@linaro.org>
 <4352730.lnFJpo5XeV@wuerfel>
Message-ID: <CAK9yfHxzvuPVt1pGdbt3f1i9g9mNzzL+Oa8oSRY+20xcNSMQ0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 May 2014 13:46, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 21 May 2014 12:22:48 Sachin Kamat wrote:
>>  # Configuration options for the EXYNOS4
>>
>> +config ARCH_EXYNOS
>> +       bool "Samsung EXYNOS" if ARCH_MULTI_V7
>> +       select ARCH_HAS_BANDGAP
>> +       select ARCH_HAS_CPUFREQ
>> +       select ARCH_HAS_HOLES_MEMORYMODEL
>> +       select ARCH_REQUIRE_GPIOLIB
>> +       select ARM_AMBA
>> +       select ARM_GIC
>> +       select CLKSRC_OF
>> +       select COMMON_CLK_SAMSUNG
>> +       select CPU_V7
>> +       select GENERIC_CLOCKEVENTS
>> +       select HAVE_ARM_SCU if SMP
>> +       select HAVE_S3C2410_I2C if I2C
>> +       select HAVE_S3C2410_WATCHDOG if WATCHDOG
>> +       select HAVE_S3C_RTC if RTC_CLASS
>> +       select HAVE_SMP
>> +       select PINCTRL
>> +       select PINCTRL_EXYNOS
>> +       select PM_GENERIC_DOMAINS if PM_RUNTIME
>> +       select S5P_DEV_MFC
>> +       select SAMSUNG_DMADEV
>> +       select SPARSE_IRQ
>> +       select SRAM
>> +       select USE_OF
>> +       help
>> +         Support for SAMSUNG EXYNOS SoCs (EXYNOS4/5)
>> +
>>
>
> A number of these can be removed now: SPARSE_IRQ, USE_OF, GENERIC_CLOCKEVENTS,
> CLKSRC_OF, CPU_V7 and HAVE_SMP are implied by ARCH_MULTIPLATFORM or ARCH_MULTI_V7,
> so we shouldn't duplicate them here.

OK.

>
> I believe SAMSUNG_DMADEV cannot work in multiplatform, but we also don't need
> it any more.

Yes this is no longer needed now that we use generic DMA engine. Will
remove this too.
Thanks for the review.

-- 
With warm regards,
Sachin
