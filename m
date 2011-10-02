From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 02 Oct 2011 20:00:31 +0200
Subject: [PATCH 15/30] usb/musb: use a Kconfig choice to pick the right
	DMA method
In-Reply-To: <20111002161447.GC12323@n2100.arm.linux.org.uk>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-16-git-send-email-arnd@arndb.de>
	<20111002161447.GC12323@n2100.arm.linux.org.uk>
Message-ID: <1757336.Qk72n3s00p@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 02 October 2011 17:14:47 Russell King - ARM Linux wrote:
> On Sun, Oct 02, 2011 at 04:45:45PM +0200, Arnd Bergmann wrote:
> > The logic to allow only one DMA driver in MUSB is currently
> > flawed, because it also allows picking no DMA driver at all
> > and also not selecting PIO mode.
> > 
> > Using a choice statement makes this foolproof for now and
> > also simplifies the Makefile.
> > 
> > Unfortunately, we will have to revisit this when we start
> > supporting multiple ARM platforms in a single kernel binary,
> > because at that point we will actually need to select
> > multiple DMA drivers and pick the right one at run-time.
> 
> I thought there was some work going on to convert this to use the
> dmaengine stuff?

That would certainly be the best solution here, I wasn't aware
that it has already been discussed.

Unfortunately, even with the dma parts out of the way there is
a lot that needs to be done to make musb, ehci or ohci
really cross-platform. Right now, you can only have one
platform driver glue for each of those drivers, and they
should eventually be converted to a large library module for
the core, with independent platform driver front-end, similar
to the recent conversion of the sdhci driver by Shawn Guo,
and the way that a lot of the other common drivers work.

	Arnd
