From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 18 Apr 2014 15:08:26 +0800
Subject: [PATCH v3 02/13] ARM: append ARCH_MULTI_V7_LPAE
In-Reply-To: <5350CC9B.2090102@free-electrons.com>
References: <1397801156-25682-1-git-send-email-haojian.zhuang@linaro.org>
 <1397801156-25682-3-git-send-email-haojian.zhuang@linaro.org>
 <5350CC9B.2090102@free-electrons.com>
Message-ID: <CAD6h2NR=4-hs7mURUPojLFY+r1t5HyysRG_oRsWhz8HVr_vYog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 April 2014 14:56, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> Hi Haojian,
>
> On 18/04/2014 08:05, Haojian Zhuang wrote:
>> Add new ARCH_MULTI_V7_LPAE config. It will select ARM_LPAE only both
>> ARCH_MULTI_V6 & ARCH_MULTI_V7 is disabled.
>>
>> ARCH_MULTI_V7 means non-LPAE platform.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>> ---
>>  arch/arm/Kconfig               | 9 ++++++++-
>>  arch/arm/mach-berlin/Kconfig   | 2 +-
>>  arch/arm/mach-highbank/Kconfig | 2 +-
>>  arch/arm/mach-mvebu/Kconfig    | 6 +++---
>>  arch/arm/mach-omap2/Kconfig    | 4 ++--
>>  arch/arm/mach-qcom/Kconfig     | 2 +-
>>  arch/arm/mach-shmobile/Kconfig | 2 +-
>>  arch/arm/mach-tegra/Kconfig    | 2 +-
>>  arch/arm/mach-vexpress/Kconfig | 2 +-
>>  9 files changed, 19 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index ab438cb..9a2214e 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -918,12 +918,19 @@ config ARCH_MULTI_V6
>>       select CPU_V6K
>>
>>  config ARCH_MULTI_V7
>> -     bool "ARMv7 based platforms (Cortex-A, PJ4, Scorpion, Krait)"
>> +     bool "ARMv7 non-LPAE based platforms (Cortex-A5/A8/A9, PJ4, Scorpion)"
> Actually some PJ4B are also non LPAE capable
>
>
>>       default y
>>       select ARCH_MULTI_V6_V7
>>       select CPU_V7
>>       select HAVE_SMP
>>
>> +config ARCH_MULTI_V7_LPAE
>> +     bool "ARMv7 LPAE based platforms (Cortex-A7/A12/A15/A17, Brahma-B15, PJ4B, Krait)"
> Only Armada XP is LPAE capable, and and the CPU is not a "simple" PJ4B
> but a PJ4B-MP

Do you mind that I append CPU_PJ4B_MP?

>>
>>  config MACH_ARMADA_370
>> -     bool "Marvell Armada 370 boards" if ARCH_MULTI_V7
>> +     bool "Marvell Armada 370 boards" if ARCH_MULTI_V7_LPAE
> Armada 370 is not LPAE capable
>
>>       select ARMADA_370_CLK
>>       select CPU_PJ4B
>>       select MACH_MVEBU_V7
>> @@ -59,7 +59,7 @@ config MACH_ARMADA_38X
>>         on the Marvell Armada 380/385 SoC with device tree.
>>
>>  config MACH_ARMADA_XP
>> -     bool "Marvell Armada XP boards" if ARCH_MULTI_V7
>> +     bool "Marvell Armada XP boards" if ARCH_MULTI_V7_LPAE
>>       select ARMADA_XP_CLK
>>       select CPU_PJ4B
>>       select MACH_MVEBU_V7
>
>
> Thanks,
>
> Gregory
>
>
> --
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
