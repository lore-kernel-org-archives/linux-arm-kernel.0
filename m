From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 17 Feb 2014 12:08:46 +0100
Subject: [PATCH] ARM: shmobile: Remove __init from
 rcar_gen2_read_mode_pins()
In-Reply-To: <1453243.5L1W6bkVz8@avalon>
References: <20140217063510.21892.52120.sendpatchset@w520>
 <1453243.5L1W6bkVz8@avalon>
Message-ID: <CAMuHMdWua-1ArMPqk1tnBk9Cz=oDOtff0bbOwPcTiGGHqqJnJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 11:59 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> --- 0001/arch/arm/mach-shmobile/setup-rcar-gen2.c
>> +++ work/arch/arm/mach-shmobile/setup-rcar-gen2.c     2014-02-17
>> 15:02:48.000000000 +0900 @@ -28,7 +28,7 @@
>>
>>  #define MODEMR 0xe6160060
>>
>> -u32 __init rcar_gen2_read_mode_pins(void)
>> +u32 rcar_gen2_read_mode_pins(void)
>>  {
>>       void __iomem *modemr = ioremap_nocache(MODEMR, 4);
>>       u32 mode;
>
> Should we read the value once at boot time and cache it ?

That sounds like a great idea to me. The value doesn't change, and
it avoids the ioremap()/iounmap() overhead on subsequent calls.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
