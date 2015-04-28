From: valentinrothberg@gmail.com (Valentin Rothberg)
Date: Tue, 28 Apr 2015 17:52:48 +0200
Subject: ARM: shmobile: ARCH_R8A7793?
In-Reply-To: <CAMuHMdUFZo+r-N0Ofa1d6PHDtB6dqZfChpLgOz_XtruWD3_a3g@mail.gmail.com>
References: <1416302641.7024.7.camel@x220>
 <CAMuHMdUFZo+r-N0Ofa1d6PHDtB6dqZfChpLgOz_XtruWD3_a3g@mail.gmail.com>
Message-ID: <CAD3Xx4LHqD44LzfHmhDQh59S_YBV1kRkowo9JWDE7EzoRUySKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

I am cleaning up some Kconfig issues in ARM
(./scripts/checkkconfgisymbols.py) at the moment and came across
CONFIG_ARCH_R8A7793:

arch/arm/Kconfig.debug:         depends on ARCH_R8A7790 ||
ARCH_R8A7791 || ARCH_R8A7793
drivers/clk/shmobile/Makefile:obj-$(CONFIG_ARCH_R8A7793)
 += clk-rcar-gen2.o

Do you know when this option will be added to Kconfig (see email below)?

Kind regards,
 Valentin

On Tue, Nov 18, 2014 at 10:36 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Paul,
>
> On Tue, Nov 18, 2014 at 10:24 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
>> Your commit 7a2071c58f36 ("ARM: shmobile: Add early debugging support
>> using SCIF(A)") is included in today's linux-next (ie, next-20141118).
>> It adds an (optional) dependency on the Kconfig symbol ARCH_R8A7793. But
>> that symbol isn't part of next-20141118.
>>
>> Is a patch that adds this symbol queued somewhere?
>
> Not yet. I was just a bit pro-active ;-)
>
> However, there are already references to r8a7793 in DT binding documentation,
> and in of_device_id arrays in drivers.
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
