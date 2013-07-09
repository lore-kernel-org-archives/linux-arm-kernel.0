From: marex@denx.de (Marek Vasut)
Date: Tue, 9 Jul 2013 17:07:03 +0200
Subject: Chipidea usb otg support for IMX/MXS (device functionality)
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803EFB072@039-SN2MPN1-023.039d.mgd.msft.net>
References: <51A5A808.2070803@digi.com> <201306221529.53043.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803EFB072@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <201307091707.03749.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

> > Hi Peter,
> > 
> > > > Peter, I dunno if you are already aware of it, but the USB peripheral
> > > > mode hangs
> > > > on MX233. It's easy to replicate for example if you try to run CDC
> > > > ethernet over
> > > > the USB peripheral mode, then telnet into the board and run "dmesg" .
> > > > This will
> > > > trigger a "larger" data transfer which will make the UDC driver hang.
> > > > This
> > > > doesn't happen on MX28 so it must be some MX233-specific thing.
> > > 
> > > Marek, Have you tried below?
> > > 
> > > http://marc.info/?l=linux-usb&m=136537318510847&w=2
> > > 
> > > It may not the USB itself problem, the mx23's usb is almost
> > > the same with mx28's.
> > 
> > This also happens on a different MX23-based board for me. This other
> > board I
> > tried has mDDR DRAM and the DRAM is operating correctly. The 96MHz thing
> > people
> > complained about in the Olimex forum is resolved now.
> 
> Add shawn.
> 
> Marek, have you tried mx23 evk?

Ok, I just tried the MX23EVK. Running "dmesg" via telnet connection resulted in 
a hang of the USB driver (likely), but since I have serial connection to the 
board, I was able to verify the board itself didn't crash. I can still operate 
the board via serial console, it's only the USB in peripheral mode ethernet that 
is hung.

> Shawn, marek reported the udc function at mx23 works abnormal, but it works
> good at mx28. Have you tried mx23 udc recently?
> 
> Best regards,
> Peter

Best regards,
Marek Vasut
