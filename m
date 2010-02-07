From: daniel@caiaq.de (Daniel Mack)
Date: Sun, 7 Feb 2010 06:13:43 +0100
Subject: [PXA320] How to find I/O registers, base address of ASIX
	ethernet chip?
In-Reply-To: <33291265356930@webmail116.yandex.ru>
References: <19621265275300@webmail108.yandex.ru>
	<20100205042655.GR28972@buzzloop.caiaq.de>
	<33291265356930@webmail116.yandex.ru>
Message-ID: <20100207051343.GL9007@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 05, 2010 at 11:02:10AM +0300, Dennis Semakin wrote:
> >  The addresses passed to the driver is the I/O area of the chip select
> >  signal used for the Ethernet chip. This setting should be alright, as it
> >  worked well for me.
> >  
> >  If your kernel hangs when accessing this area, you most probably haven't
> >  set up your static bus correctly. The bootloader is in charge of doing
> >  this, and the correct value for CSADRCFG2 is 0x0032C809.
> >  
> >  Also see http://openpxa.sourceforge.net/ for patches to U-Boot and more
> >  information about replacing the native bootloader the modules ships
> >  with.
> >  
> >  Daniel
> >  
> 
> In U-BOOT:
> 
> MSC1 (address 0x4a00000c) - 0x0779
> $ md.w 0x4a00000c
> 4a00000c: 0779 0000 0000 0000 0000 0000 0000 0000 y...............
> 4a00001c: 0008 0000 0000 0000 0000 0000 0000 0000 ................
> 4a00002c: 0000 0000 0000 0000 0000 0000 0000 0000 ................
> 4a00003c: 0000 0000 0000 0000 0000 0000 0000 0000 ................
> 
> CSADRCFG2 (address 0x4a000088) - 0032c809
> $ md.l 0x4a000088
> 4a000088: 0032c809 00020000 00020000 00000000 ..2.............
> 4a000098: 00000000 00000000 00000000 00000000 ................
> 4a0000a8: 00000000 00000000 00000000 00000000 ................
> 4a0000b8: 00000000 00000000 00000000 00000000 ................
> 4a0000c8: 00000000 00000000 00000000 00000000 ................

Can you access 0x1000_0000 from U-Boot? Did you switch on the clock for
the static bus? This is also not done by the kernel currently.

Daniel
