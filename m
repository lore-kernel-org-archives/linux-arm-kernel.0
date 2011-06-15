From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 15 Jun 2011 13:24:24 +0200
Subject: [RFC,PATCH] Cleanup PC parallel port Kconfig
In-Reply-To: <201106151146.13320.arnd@arndb.de>
References: <20110614190850.GA13526@linux-mips.org>
	<201106142333.16203.arnd@arndb.de> <4DF83577.6040903@zytor.com>
	<201106151146.13320.arnd@arndb.de>
Message-ID: <BANLkTimMLDb6LL0HZv8XtHt=zvyE7eybyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2011 at 11:46, Arnd Bergmann <arnd@arndb.de> wrote:
> * In case of floppies, the "solution" was to write a driver for every platform that
> ?doesn't have PIO, since they tend to have other differences. The amiflop and
> ?ataflop drivers are not even use readb(), they just derefence volatile pointers
> ?to do MMIO. I doubt we can find volunteers to clean that up.

Amiflop drives the Amiga floppy controller, which is completely
different from the
PC-style floppy controller.
Ataflop drives the Atari floppy controller, which seems to be a WD1772 and not
related to PC-style floppy controllers neither.

So none of them drive PC-style hardware, and both predate the generic readb()
infrastructure.

Gr{oetje,eeting}s,

? ? ? ? ? ? ? ? ? ? ? ? Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
? ? ? ? ? ? ? ? ? ? ? ? ? ?? ?? -- Linus Torvalds
