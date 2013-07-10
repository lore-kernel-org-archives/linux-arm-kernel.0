From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Wed, 10 Jul 2013 17:29:26 +0200
Subject: [PATCH V2 01/12] spi/mxs: Always set LOCK_CS
In-Reply-To: <CAOMZO5AEU3D3o-8fKLQJvsRSwBMNn0jfwZFC6R93TKaUpxffSw@mail.gmail.com>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
 <201304030118.42976.marex@denx.de>
 <CAOMZO5AEU3D3o-8fKLQJvsRSwBMNn0jfwZFC6R93TKaUpxffSw@mail.gmail.com>
Message-ID: <20957.32214.721252.361301@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Fabio Estevam writes:
> On Tue, Apr 2, 2013 at 8:18 PM, Marek Vasut <marex@denx.de> wrote:
> > Dear Trent Piepho,
> >
> >> There are two bits which control the CS line in the CTRL0 register:
> >> LOCK_CS and IGNORE_CRC.  The latter would be better named DEASSERT_CS
> >> in SPI mode.
> >>
> >> LOCK_CS keeps CS asserted though the entire transfer.  This should
> >> always be set.  The DMA code will always set it, explicitly on the
> >> first segment of the first transfer, and then implicitly on all the
> >> rest by never clearing the bit from the value read from the ctrl0
> >> register.
> >>
> >> The only reason to not set LOCK_CS would be to attempt an altered
> >> protocol where CS pulses between each word.  Though don't get your
> >> hopes up if you want to do this, as the hardware doesn't appear to do
> >> this in any sane manner.
> >
> > Can you please elaborate on this part above? The description is very vague.
> >
>From my experience the HW deasserts CS whenever the output fifo runs
empty.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
