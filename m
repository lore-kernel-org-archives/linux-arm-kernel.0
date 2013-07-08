From: olof@lixom.net (Olof Johansson)
Date: Mon, 8 Jul 2013 04:34:33 -0700
Subject: [PATCH 4/8] ARM: OMAP: build mach-omap code only if needed
In-Reply-To: <CAOesGMg2f2iRuanVkDOR6m459oQou6J8oJC3Enm_rrS2WMM3hA@mail.gmail.com>
References: <1373041417-217728-1-git-send-email-arnd@arndb.de>
 <1373041417-217728-5-git-send-email-arnd@arndb.de>
 <CAOesGMg2f2iRuanVkDOR6m459oQou6J8oJC3Enm_rrS2WMM3hA@mail.gmail.com>
Message-ID: <CAOesGMjAp-myzFbMh9dyaaz_xCVtAo7z9FJh7pweVMqPK=wKoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[fixed linux-arm-kernel address]

On Mon, Jul 8, 2013 at 4:31 AM, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> I think this broke multi_v7_defconfig in last night's linux-next, due
> to TI_PRIV_EDMA no longer being selected. Looks like you missed it
> when moving the options around:
>
> On Fri, Jul 5, 2013 at 9:23 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
>> index 1f8127a..5c14051 100644
>> --- a/arch/arm/mach-omap2/Kconfig
>> +++ b/arch/arm/mach-omap2/Kconfig
>> @@ -1,62 +1,10 @@
>>  config ARCH_OMAP
>>         bool
>>
>> -config ARCH_OMAP2PLUS
>> -       bool "TI OMAP2/3/4/5 SoCs with device tree support" if (ARCH_MULTI_V6 || ARCH_MULTI_V7)
>> -       select ARCH_HAS_CPUFREQ
>> -       select ARCH_HAS_HOLES_MEMORYMODEL
>> -       select ARCH_OMAP
>> -       select ARCH_REQUIRE_GPIOLIB
>> -       select CLKDEV_LOOKUP
>> -       select CLKSRC_MMIO
>> -       select GENERIC_CLOCKEVENTS
>> -       select GENERIC_IRQ_CHIP
>> -       select HAVE_CLK
>> -       select OMAP_DM_TIMER
>> -       select PINCTRL
>> -       select PROC_DEVICETREE if PROC_FS
>> -       select SOC_BUS
>> -       select SPARSE_IRQ
>> -       select TI_PRIV_EDMA
>> -       select USE_OF
>> -       help
>> -         Systems based on OMAP2, OMAP3, OMAP4 or OMAP5
> [...]
>> +config ARCH_OMAP2PLUS
>> +       bool
>> +       select ARCH_HAS_BANDGAP
>> +       select ARCH_HAS_CPUFREQ
>> +       select ARCH_HAS_HOLES_MEMORYMODEL
>> +       select ARCH_OMAP
>> +       select ARCH_REQUIRE_GPIOLIB
>> +       select CLKDEV_LOOKUP
>> +       select CLKSRC_MMIO
>> +       select GENERIC_CLOCKEVENTS
>> +       select GENERIC_IRQ_CHIP
>> +       select HAVE_CLK
>> +       select OMAP_DM_TIMER
>> +       select PINCTRL
>> +       select PROC_DEVICETREE if PROC_FS
>> +       select SOC_BUS
>> +       select SPARSE_IRQ
>> +       select USE_OF
>> +       help
>> +         Systems based on OMAP2, OMAP3, OMAP4 or OMAP5
>
>
> -Olof
