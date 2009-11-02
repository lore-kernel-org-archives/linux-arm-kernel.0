From: ajay.gupta@ti.com (Gupta, Ajay Kumar)
Date: Mon, 2 Nov 2009 16:54:00 +0530
Subject: [PATCH RFC 1/2] MUSB: CPPI 4.1 DMA driver (take 4)
In-Reply-To: <20091102110216.GF9446@nokia.com>
References: <200908142241.00528.sshtylyov@ru.mvista.com>
	<4A8A202E.2040505@windriver.com> <4A8A7047.9080405@ru.mvista.com>
	<4A8CF552.3080801@windriver.com>
	<19F8576C6E063C45BE387C64729E73940436EEAE36@dbde02.ent.ti.com>
	<4AE85B02.1080207@ru.mvista.com>
	<19F8576C6E063C45BE387C64729E73940436EEAE60@dbde02.ent.ti.com>
	<19F8576C6E063C45BE387C64729E73940436EEB489@dbde02.ent.ti.com>
	<20091102103706.GB1133@n2100.arm.linux.org.uk>
	<19F8576C6E063C45BE387C64729E73940436EEB5EF@dbde02.ent.ti.com>
	<20091102110216.GF9446@nokia.com>
Message-ID: <19F8576C6E063C45BE387C64729E73940436EEB601@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >
> > > If it's a USB DMA device (from the patches I can find, that seems to
> be
> > > the case) then why can't it live in drivers/usb or drivers/dma ?
> >
> > CPPI4.1 DMA engine can be used either by USB or by Ethernet interface
> though
> > currently only USB is using it but in future even Ethernet devices may
> use it.
> >
> > Infact, there is a TI platform (not in mainline), where both USB and
> Ethernet interface is using CPPI4.1 DMA.
> 
> you might want to provide support for it via drivers/dma and for the
> musb stuff, you just add the wrappers musb uses. See how tusb6010_omap.c
> uses OMAP's system dma which is also used by any other driver which
> requests a dma channel.

Sounds good. 

So if we want to move CPPI4.1 DMA core to drivers/dma then it has to follow
standard set of DMA APIs (right?), which I afraid, may not be done in current implementation.

Regards,
Ajay
  
> --
> balbi
