From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 21 Aug 2012 10:06:50 +0800
Subject: [PATCH 2/3] ARM: PRIMA2: make mach-prima2 common for all SiRF
 series SoC
In-Reply-To: <201208202106.43206.arnd@arndb.de>
References: <1345450787-17246-1-git-send-email-Barry.Song@csr.com>
 <1345450787-17246-3-git-send-email-Barry.Song@csr.com>
 <201208202106.43206.arnd@arndb.de>
Message-ID: <CAGsJ_4yWzdzJMrCqWWozKBrkSJ7O5thpP+mYTTEsN8+AuO03wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

more comments.

2012/8/21 Arnd Bergmann <arnd@arndb.de>:
> On Monday 20 August 2012, Barry Song wrote:
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> We will have SiRF Marco and Polo, so rename the dir to mach-sirf
>> and add Kconfig menu
>>
>> Signed-off-by: Baohua Song <Baohua.Song@csr.com>
>> ---
>>  arch/arm/Kconfig                                   |   10 +++++-----
>>  arch/arm/Makefile                                  |    2 +-
>>  arch/arm/mach-sirf/Kconfig                         |   16 ++++++++++++++++
>>  arch/arm/{mach-prima2 => mach-sirf}/Makefile       |    0
>>  arch/arm/{mach-prima2 => mach-sirf}/Makefile.boot  |    0
>>  .../arm/{mach-prima2 => mach-sirf}/board-generic.c |    0
>>  arch/arm/{mach-prima2 => mach-sirf}/common.h       |    0
>>  .../include/mach/clkdev.h                          |    0
>>  .../include/mach/debug-macro.S                     |    0
>>  .../include/mach/entry-macro.S                     |    0
>>  .../{mach-prima2 => mach-sirf}/include/mach/gpio.h |    0
>>  .../include/mach/hardware.h                        |    0
>>  .../{mach-prima2 => mach-sirf}/include/mach/irqs.h |    0
>>  .../{mach-prima2 => mach-sirf}/include/mach/map.h  |    0
>
> I'm not sure if we should rename all of these right now. I've been thinking
> about moving all of recent and simple ARMv7 based platforms (socfpga, zynq,
> prima2, ...) into a single directory, where they would basically end up
> being one file per platform. We should discuss this at the ARM mini summit,
> and I can let you know the outcome of it. I don't object on the rename in
> principle, but it might end up causing extra churn.

we will have other SoCs which are more complex than primaII. i am not
sure whether you can merge all of them into a single dir together with
zynq or other platforms.
i am debugging the patches of MARCO and will send them soon. this
series is just preparing for delivering MARCO patches.

>
>> +if ARCH_SIRF
>> +
>> +choice
>> +       prompt "Qualcomm SiRF SoC Type"
>> +       default ARCH_PRIMA2
>
> I'm curious about this: I did read that Samsung acquired CSR, and
> you list the chips as Qualcomm. What's the story here?

BTW, i just want to clarify Samsung  acquired the mobile business of
CSR, not including our primaII or other SoCs.

>
>> +config ARCH_PRIMA2
>> +       bool "CSR SiRFSoC PRIMA2 ARM Cortex A9 Platform"
>> +       select CPU_V7
>> +       select ZONE_DMA
>> +       help
>> +          Support for CSR SiRFSoC ARM Cortex A9 Platform
>> +
>> +endchoice
>
> Is this still needed? When you add other SoC type here, would you
> build kernels that are for just one of them in practice?  If they
> are completely generic anyway, you can skip the submenu.
>
>         Arnd
>

-barry
