From: marex@denx.de (Marek Vasut)
Date: Mon, 24 Jun 2013 15:51:19 +0200
Subject: Chipidea usb otg support for IMX/MXS (device functionality)
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803EFB072@039-SN2MPN1-023.039d.mgd.msft.net>
References: <51A5A808.2070803@digi.com> <201306221529.53043.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803EFB072@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <201306241551.19831.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Peter,

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

No, I don't have this one available right now. I tried both MX23 Olinuxino maxi 
(I just mutilated the board so that I cut traces to the USB devices on the board 
and routed out USB gadget connector) and a custom MX23 board.

Note that both have working USB peripheral mode in U-Boot too, but the driver in 
U-Boot is very minimalistic.

> Shawn, marek reported the udc function at mx23 works abnormal, but it works
> good at mx28. Have you tried mx23 udc recently?

Fabio, can you possibly test on MX23EVK please?

Best regards,
Marek Vasut
