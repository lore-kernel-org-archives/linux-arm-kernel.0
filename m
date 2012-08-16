From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Aug 2012 09:06:21 +0000
Subject: [PATCH] dma: amba-pl08x: Export pl08x_filter_id
In-Reply-To: <20120816090041.GK18957@n2100.arm.linux.org.uk>
References: <1345107396-27079-1-git-send-email-stigge@antcom.de>
 <20120816090041.GK18957@n2100.arm.linux.org.uk>
Message-ID: <201208160906.21950.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 August 2012, Russell King - ARM Linux wrote:
> On Thu, Aug 16, 2012 at 10:56:36AM +0200, Roland Stigge wrote:
> > This patch fixes the following when compiling a driver module that uses
> > amba-pl08x:
> > 
> > ERROR: "pl08x_filter_id" [drivers/mtd/nand/lpc32xx_slc.ko] undefined!
> > ERROR: "pl08x_filter_id" [drivers/mtd/nand/lpc32xx_mlc.ko] undefined!
> > 
> > (drivers/mtd/nand/lpc32xx_* are still in l2-mtd.git)
> 
> It is currently intended that this be passed from platform code into
> drivers via platform data, so that drivers can decide which DMA engine
> they wish to make use of.
> 
> See how all the AMBA drivers work in this regard (because they need to
> support more than just a single DMA engine implementation.)

Ah, you're right, I forgot about that. I'll take back my Ack then.

	Arnd
