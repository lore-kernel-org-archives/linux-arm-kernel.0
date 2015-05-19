From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 19 May 2015 10:45:14 +0200
Subject: [PATCH v4 1/7] ARM: lpc18xx: add basic support for NXP
 LPC18xx/43xx SoCs
In-Reply-To: <CAGhQ9Vy6ByVtpbebMiSCQoQfbKMvtpyt85dShW_gav=CQ6vDWQ@mail.gmail.com>
References: <1431381653-25356-1-git-send-email-manabian@gmail.com>
 <1431381653-25356-2-git-send-email-manabian@gmail.com>
 <CAMuHMdVfh6-Y6BuRpxXRJexXK+U-Bp0P+W-2e4ioAZ=60C_TYQ@mail.gmail.com>
 <CAGhQ9Vy6ByVtpbebMiSCQoQfbKMvtpyt85dShW_gav=CQ6vDWQ@mail.gmail.com>
Message-ID: <CAMuHMdXvvJDE1V=fQM7h8RDQOCy71zEG2S0LO17QSJdtd3tfrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joachim,

On Tue, May 19, 2015 at 10:39 AM, Joachim  Eastwood <manabian@gmail.com> wrote:
> On 19 May 2015 at 09:26, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Tue, May 12, 2015 at 12:00 AM, Joachim Eastwood <manabian@gmail.com> wrote:
>>> --- a/arch/arm/Kconfig.debug
>>> +++ b/arch/arm/Kconfig.debug
>>> @@ -1359,6 +1359,7 @@ config DEBUG_UART_PHYS
>>>         default 0x20201000 if DEBUG_BCM2835
>>>         default 0x3e000000 if DEBUG_BCM_KONA_UART
>>>         default 0x4000e400 if DEBUG_LL_UART_EFM32
>>> +       default 0x40081000 if ARCH_LPC18XX
>>
>> This will be used in any multi-platform kernel with DEBUG_LL=y,  possible
>> overriding a correct value, even if low-level LPC18XX debug support itself
>> (what's the config option for that, I couldn't find it?) is disabled.
>
> Right now LPC18xx can't be a part of any multi-platform kernel.

Oops. Sorry for the noise, I completely overlooked that...
So it doesn't bite us (yet).

>> Please make this dependent on an appropriate DEBUG_LPC18XX
>> option. Thanks!
>
> But anyways defining a DEBUG_LPC18XX symbol seems to be what most
> other platforms do. I'll send a follow up patch defining DEBUG_LPC18XX
> and then use that in DEBUG_UART_PHYS.

Nevertheless, IMHO it's still good to have, thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
