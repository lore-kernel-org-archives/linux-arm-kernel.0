From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 13 Apr 2016 21:50:22 +0200
Subject: [PATCH 2/2] ARM: shmobile: timer: Drop support for Cortex A8
In-Reply-To: <CAOesGMi5cwiGqj-m78X4sbpqj+_aRNXDahs-XpaggK8=fNhRKg@mail.gmail.com>
References: <cover.1459732456.git.horms+renesas@verge.net.au>
 <cd89841fc6dbb6dc11aa113769f39dcd30be720f.1459732456.git.horms+renesas@verge.net.au>
 <CAOesGMi5cwiGqj-m78X4sbpqj+_aRNXDahs-XpaggK8=fNhRKg@mail.gmail.com>
Message-ID: <CAMuHMdWKq-PpsnDiij=nPK1zcxtwU88-YHVYYStFj_Ok2=tdVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Wed, Apr 13, 2016 at 9:41 PM, Olof Johansson <olof@lixom.net> wrote:
> On Sun, Apr 3, 2016 at 6:22 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
>> From: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> Commit edf4100906044225 ("ARM: shmobile: sh7372 dtsi: Remove Legacy
>> file") removed the DTS for the last shmobile SoC with a Cortex A8 CPU
>> core (sh7372 aka SH-Mobile AP4).
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>> ---
>>  arch/arm/mach-shmobile/timer.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
>> index 67d79f9c6bad..1fc7759feab1 100644
>> --- a/arch/arm/mach-shmobile/timer.c
>> +++ b/arch/arm/mach-shmobile/timer.c
>> @@ -54,9 +54,7 @@ void __init shmobile_init_delay(void)
>>                 if (!of_property_read_u32(np, "clock-frequency", &freq))
>>                         max_freq = max(max_freq, freq);
>>
>> -               if (of_device_is_compatible(np, "arm,cortex-a8")) {
>> -                       div = 2;
>> -               } else if (of_device_is_compatible(np, "arm,cortex-a9")) {
>> +               if (of_device_is_compatible(np, "arm,cortex-a9")) {
>>                         div = 1;
>>                 } else if (of_device_is_compatible(np, "arm,cortex-a7") ||
>>                          of_device_is_compatible(np, "arm,cortex-a15")) {
>
> This setting of div doesn't make much sense now. It's always 1. This
> function seems more complicated than it has to be...

Yes, there are definitely more areas for improvement in this organic piece of
code...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
