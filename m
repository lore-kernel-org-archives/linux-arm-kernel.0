From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 27 Oct 2016 09:33:47 +0200
Subject: [PATCH] ARM: shmobile: select errata 798181 for SoCs with CA15
 cores
In-Reply-To: <CANqRtoSsKTvMjATz89nEY06Fp-J20VqjDzW0JD1NDLqEJQPwsQ@mail.gmail.com>
References: <1477551606-6903-1-git-send-email-horms+renesas@verge.net.au>
 <CANqRtoSsKTvMjATz89nEY06Fp-J20VqjDzW0JD1NDLqEJQPwsQ@mail.gmail.com>
Message-ID: <CAMuHMdVKwg0SzEmu804UxTEE+N4atYjeKHNfCJ0eXf28fL+KJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Thu, Oct 27, 2016 at 9:28 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Thu, Oct 27, 2016 at 4:00 PM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
>> Select ARM errata 798181 on SoCs cores affected CA15 cores.
>>
>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>> ---
>>  arch/arm/mach-shmobile/Kconfig | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
>> index c48be1d332ed..6fbd9b7d2d67 100644
>> --- a/arch/arm/mach-shmobile/Kconfig
>> +++ b/arch/arm/mach-shmobile/Kconfig
>> @@ -60,6 +60,7 @@ config ARCH_R7S72100
>>  config ARCH_R8A73A4
>>         bool "R-Mobile APE6 (R8A73A40)"
>>         select ARCH_RMOBILE
>> +       select ARM_ERRATA_798181 if SMP
>>         select RENESAS_IRQC
>>
>>  config ARCH_R8A7740
>> @@ -70,6 +71,7 @@ config ARCH_R8A7740
>>  config ARCH_R8A7743
>>         bool "RZ/G1M (R8A77430)"
>>         select ARCH_RCAR_GEN2
>> +       select ARM_ERRATA_798181 if SMP
>>
>>  config ARCH_R8A7778
>>         bool "R-Car M1A (R8A77781)"
>> @@ -82,20 +84,24 @@ config ARCH_R8A7779
>>  config ARCH_R8A7790
>>         bool "R-Car H2 (R8A77900)"
>>         select ARCH_RCAR_GEN2
>> +       select ARM_ERRATA_798181 if SMP
>>         select I2C
>
> Thanks for your help.
>
> I'm probably misunderstanding what this patch does and how the errata
> effects the system, but the commit message says CA15 cores. The above
> R-Car Gen1 and r8a7740 SoCs are not using CA15 - instead they use CA9.
> Not sure if the errata still applies though.

Please don't become misled by the @@ context ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
