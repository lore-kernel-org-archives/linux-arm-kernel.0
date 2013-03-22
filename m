From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Mar 2013 20:05:31 +0000
Subject: Integrator PCI base dilemma
In-Reply-To: <CACRpkdb5Q+EtM0GGaLFNUj1A12zVrcyUxzRvfEOpcH4-pVuasA@mail.gmail.com>
References: <CACRpkdaOjFhWR21w5x_rR_60ffQF3Ym_MQd2svNyzm0guwOUoQ@mail.gmail.com>
 <20130322103740.GW4977@n2100.arm.linux.org.uk>
 <CACRpkdb5Q+EtM0GGaLFNUj1A12zVrcyUxzRvfEOpcH4-pVuasA@mail.gmail.com>
Message-ID: <201303222005.32146.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 March 2013, Linus Walleij wrote:
> > There are two boot loaders I'm aware of which are capable of doing this,
> > and those are MILO and my boot loader for Footbridge platforms (which,
> > incidentally, now runs ATA card BIOSes too complete with input support
> > and can push out the VGA output via serial and accept keypresses via
> > serial) - and that doesn't work on Integrator/AP.
> 
> I'm on U-boot for this thing, I wonder if that can do x86
> emulation to initialize VGA card. I guess I'm about to learn.

You should be able to do it from user space using Matthew Garrett's
vbetool[1]. If I understood it right, you can initialize the VGA
card with this, and then load vga16fb or vgacon.

If the card is VESA 2.0 compatible, you should also be able to use
it with uvesafb, which calls /sbin/v86d for x86 emulation.

	Arnd

[1] http://www.codon.org.uk/~mjg59/vbetool/
