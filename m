From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 May 2015 11:11:31 +0200
Subject: [PATCH v4 1/7] ARM: lpc18xx: add basic support for NXP
 LPC18xx/43xx SoCs
In-Reply-To: <CAMuHMdXvvJDE1V=fQM7h8RDQOCy71zEG2S0LO17QSJdtd3tfrQ@mail.gmail.com>
References: <1431381653-25356-1-git-send-email-manabian@gmail.com>
 <CAGhQ9Vy6ByVtpbebMiSCQoQfbKMvtpyt85dShW_gav=CQ6vDWQ@mail.gmail.com>
 <CAMuHMdXvvJDE1V=fQM7h8RDQOCy71zEG2S0LO17QSJdtd3tfrQ@mail.gmail.com>
Message-ID: <2401619.oTy4WsRsYp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 May 2015 10:45:14 Geert Uytterhoeven wrote:
> Hi Joachim,
> 
> On Tue, May 19, 2015 at 10:39 AM, Joachim  Eastwood <manabian@gmail.com> wrote:
> > On 19 May 2015 at 09:26, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >> On Tue, May 12, 2015 at 12:00 AM, Joachim Eastwood <manabian@gmail.com> wrote:
> >>> --- a/arch/arm/Kconfig.debug
> >>> +++ b/arch/arm/Kconfig.debug
> >>> @@ -1359,6 +1359,7 @@ config DEBUG_UART_PHYS
> >>>         default 0x20201000 if DEBUG_BCM2835
> >>>         default 0x3e000000 if DEBUG_BCM_KONA_UART
> >>>         default 0x4000e400 if DEBUG_LL_UART_EFM32
> >>> +       default 0x40081000 if ARCH_LPC18XX
> >>
> >> This will be used in any multi-platform kernel with DEBUG_LL=y,  possible
> >> overriding a correct value, even if low-level LPC18XX debug support itself
> >> (what's the config option for that, I couldn't find it?) is disabled.
> >
> > Right now LPC18xx can't be a part of any multi-platform kernel.
> 
> Oops. Sorry for the noise, I completely overlooked that...
> So it doesn't bite us (yet).

I actually have a patch to convert all remaining 'if ARCH_*' dependencies
in this file the way you suggest here, and noticed the LPC18XX addition
when rebasing that one yesterday.

> >> Please make this dependent on an appropriate DEBUG_LPC18XX
> >> option. Thanks!
> >
> > But anyways defining a DEBUG_LPC18XX symbol seems to be what most
> > other platforms do. I'll send a follow up patch defining DEBUG_LPC18XX
> > and then use that in DEBUG_UART_PHYS.
> 
> Nevertheless, IMHO it's still good to have, thanks!

Agreed.

	Arnd
