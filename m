From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 22 Jul 2010 13:38:34 +0200
Subject: Introducing the LCD-Linux project
In-Reply-To: <20100722122111.4cf4ca2f@lxorguk.ukuu.org.uk>
References: <AANLkTikitTGpiE5Oe_P5a4f2OCOnlB9j_LVm5CQhQIno@mail.gmail.com>
	<20100722122111.4cf4ca2f@lxorguk.ukuu.org.uk>
Message-ID: <AANLkTilKJx18oyc815DhKfPv-Yjdv8UmfJ4WTDxZxaab@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 13:21, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Wed, 21 Jul 2010 14:57:54 +0200
> Mattia Jona-Lasinio <mattia.jona@gmail.com> wrote:
>> this is to introduce the LCD-Linux project (http://lcd-linux.sourceforge.net/),
>> a kernel level implementation of a VT102 terminal emulator, optimized for small
>> alphanumeric and graphic displays.
>
> The kernel already has a console and that provides an abstract
> implementation that is used for everything from text mode displays to vga
> to assorted accelerated hardware platforms.
>
> Why do we need a VT102 as well ?
>
>> functions. A solution is therefore to provide a sort of minimal terminal
>> emulation in kernel space, that can be accessed through the standard character
>> device interface. In this way the problem of the display management is reduced
>
> If you use the existing kernel console interfaces then you don't need to
> worry about vt102 v console or having two terminal emulations running.

Indeed, the kernel already has the console abstraction.

I wrote a LCD console driver (for a HD44780 connected to the parallel
port) using
the standard console abstraction several years ago. As it used the standard
console abstraction, it supported multiple virtual consoles and co-operated with
the VGA text console out-of-the-box. Just use ALT-Fx to switch between different
VCs on the LCD or on VGA.

I never published the code, though. Will do so tonight when I get back
to the machine
that holds the code ;-)

Having a bigger virtual console where the LCD follows the region
surrounding the cursor
is indeed a nice extension to have.

Gr{oetje,eeting}s,

? ? ? ? ? ? ? ? ? ? ? ? Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
? ? ? ? ? ? ? ? ? ? ? ? ? ?? ?? -- Linus Torvalds
