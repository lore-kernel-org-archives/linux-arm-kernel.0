From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 16 Oct 2010 23:54:20 +0200
Subject: [PATCH 0/7] arm/versatile PCI support, second try
In-Reply-To: <AANLkTikc5Vc0Q0z4rE4raX7LTyB=LiE+YuzycMjsXUaM@mail.gmail.com>
References: <1287072657-32477-1-git-send-email-arnd@arndb.de>
	<AANLkTikc5Vc0Q0z4rE4raX7LTyB=LiE+YuzycMjsXUaM@mail.gmail.com>
Message-ID: <201010162354.20418.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 16 October 2010, Linus Walleij wrote:
> 2010/10/14 Arnd Bergmann <arnd@arndb.de>:
> 
> > With lots of help and testing from Peter Maydell, I've completed
> > a second version of the PCI support for the versatile platform,
> > which works much better now on real hardware, although it does
> > not improve existing qemu setups.
> 
> I've got nothing better to do tonite than playing with the PB1176
> board so tried this out...
> 
> Some fixup is needed in 6/7, the EB patch because I get this:
> arch/arm/mach-realview/realview_eb.c:94: error:
> 'REALVIEW_PCI_CORE_BASE' undeclared here (not in a function)
> arch/arm/mach-realview/realview_eb.c:110: error:
> 'REALVIEW_PCI_IO_BASE' undeclared here (not in a function)
> arch/arm/mach-realview/realview_eb.c:111: error:
> 'REALVIEW_PCI_IO_BASE_SIZE' undeclared here (not in a function)
> make[3]: *** [arch/arm/mach-realview/realview_eb.o] Error 1
> make[2]: *** [arch/arm/mach-realview] Error 2
> make[2]: *** Waiting for unfinished jobs....
> 
> No these are indeed named
> REALVIEW_EB_PCI_CORE_BASE
> REALVIEW_EB_PCI_IO_BASE0
> etc...

Ah right, I removed these when I prepared the patches for submission,
initially I was using the common definitions for the realview boards
but I figured it would be bad since newer realviews have a different
controller. Apparently I forgot to move over the EB code to use the
new definitions I added later.

I'll fix these up.

> If I disable the EB support it compiles and boots. Nothing much
> else happens, not even if I enable PCI debugging. But I guess
> that's normal since I don't have any PCI enclosure expansion
> board for this card?

Yes, without a PCI card to plug into it it's pretty pointless.

> The only visible change is that /sys/bus/pci now exists with no
> slots nor devices in it.
> 
> But it's not causing any regressions for me so with a fix
> for the compile problem it's
> Tested-by: Linus Walleij <linus.walleij@stericsson.com>

Thanks,

	Arnd
