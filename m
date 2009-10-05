From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 5 Oct 2009 18:01:22 +0200
Subject: [PATCH v1.0 2/4] TS72XX: Allow to override machine ID
In-Reply-To: <19146.3499.156615.1713@pilspetsen.it.uu.se>
References: <20091004011413.12578.89897.stgit@localhost.localdomain>
	<4AC9E3CE.2030307@techworks.ie>
	<19146.3499.156615.1713@pilspetsen.it.uu.se>
Message-ID: <200910051801.22974.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Po 5. ??jna 2009 17:15:55 Mikael Pettersson napsal(a):
> Christian Gagneraud writes:
>  > H Hartley Sweeten wrote:
>  > > On Saturday, October 03, 2009 6:14 PM, Christian Gagneraud wrote:
>  > >> From: Matthieu Crapet <mcrapet@gmail.com>
>  > >>
>  > >> In early days Technologic Systems fixed the 0x163 value in redboot
>  > >> instead of 0x2a1, this patch allow to overwrite it.
>  > >>
>  > >> Signed-off-by: Matthieu Crapet <mcrapet@gmail.com>
>  > >> Signed-off-by: Christian Gagneraud <cgagneraud@techworks.ie>
>  > >
>  > > As others have already pointed out, this is a pure hack and not
>  > > suitable for mainline.
>  > >
>  > > The bootloader for systems that needs this really should be updated.
>  > > Machine ID 0x163 (355) is ARCH_CX861XX which isn't an ep93xx based
>  > > system and doesn't even have a platform init in mainline.
>  >
>  > I see your point, but what if the bootloader can't be updated? Does
>  > that mean that people using these boards will have to bother with
>  > applying patches on mainline kernel for ever?
>  > Can't we find a way to address this issue, I'm pretty sure this is not
>  > the only board that need this kind of asm hack.
> 
> All you need to do is to wrap the kernel binary image with
> a small shim that corrects the Machine ID in r1. devio can
> do that, as can (I think) printf(1).
> 
> No need to replace the bootloader or hack the kernel.

devio 'wl 0xe59f1000,4' 'wl 0xe28ff004,4' 'wl $MACH,4' >> id.bin
cat id.bin zImage > zImage.crippled

Like this (I used this on Toradex board where those morons fixed machine id too).
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
