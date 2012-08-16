From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Aug 2012 10:00:41 +0100
Subject: [PATCH] dma: amba-pl08x: Export pl08x_filter_id
In-Reply-To: <1345107396-27079-1-git-send-email-stigge@antcom.de>
References: <1345107396-27079-1-git-send-email-stigge@antcom.de>
Message-ID: <20120816090041.GK18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 10:56:36AM +0200, Roland Stigge wrote:
> This patch fixes the following when compiling a driver module that uses
> amba-pl08x:
> 
> ERROR: "pl08x_filter_id" [drivers/mtd/nand/lpc32xx_slc.ko] undefined!
> ERROR: "pl08x_filter_id" [drivers/mtd/nand/lpc32xx_mlc.ko] undefined!
> 
> (drivers/mtd/nand/lpc32xx_* are still in l2-mtd.git)

It is currently intended that this be passed from platform code into
drivers via platform data, so that drivers can decide which DMA engine
they wish to make use of.

See how all the AMBA drivers work in this regard (because they need to
support more than just a single DMA engine implementation.)
