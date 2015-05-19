From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 19 May 2015 11:25:29 +0200
Subject: [PATCH v4 1/7] ARM: lpc18xx: add basic support for NXP
 LPC18xx/43xx SoCs
In-Reply-To: <2401619.oTy4WsRsYp@wuerfel>
References: <1431381653-25356-1-git-send-email-manabian@gmail.com>
 <CAGhQ9Vy6ByVtpbebMiSCQoQfbKMvtpyt85dShW_gav=CQ6vDWQ@mail.gmail.com>
 <CAMuHMdXvvJDE1V=fQM7h8RDQOCy71zEG2S0LO17QSJdtd3tfrQ@mail.gmail.com>
 <2401619.oTy4WsRsYp@wuerfel>
Message-ID: <CAMuHMdXPNu9yCG_Ok1rk9xm+JkWJ0pxfVX05D8r3kzxzouFBVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, May 19, 2015 at 11:11 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 19 May 2015 10:45:14 Geert Uytterhoeven wrote:
>> On Tue, May 19, 2015 at 10:39 AM, Joachim  Eastwood <manabian@gmail.com> wrote:
>> > On 19 May 2015 at 09:26, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> >> On Tue, May 12, 2015 at 12:00 AM, Joachim Eastwood <manabian@gmail.com> wrote:
>> >>> --- a/arch/arm/Kconfig.debug
>> >>> +++ b/arch/arm/Kconfig.debug
>> >>> @@ -1359,6 +1359,7 @@ config DEBUG_UART_PHYS
>> >>>         default 0x20201000 if DEBUG_BCM2835
>> >>>         default 0x3e000000 if DEBUG_BCM_KONA_UART
>> >>>         default 0x4000e400 if DEBUG_LL_UART_EFM32
>> >>> +       default 0x40081000 if ARCH_LPC18XX
>> >>
>> >> This will be used in any multi-platform kernel with DEBUG_LL=y,  possible
>> >> overriding a correct value, even if low-level LPC18XX debug support itself
>> >> (what's the config option for that, I couldn't find it?) is disabled.
>> >
>> > Right now LPC18xx can't be a part of any multi-platform kernel.
>>
>> Oops. Sorry for the noise, I completely overlooked that...
>> So it doesn't bite us (yet).
>
> I actually have a patch to convert all remaining 'if ARCH_*' dependencies
> in this file the way you suggest here, and noticed the LPC18XX addition

Would be great to see that go in! Thanks!

> when rebasing that one yesterday.

I noticed because I have a lazy patch to remove all non-shmobile defaults ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
