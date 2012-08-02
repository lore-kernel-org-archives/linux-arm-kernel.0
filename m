From: marex@denx.de (Marek Vasut)
Date: Thu, 2 Aug 2012 17:00:42 +0200
Subject: [PATCH 08/10 RESEND] spi: Add DMA support into SPI driver
In-Reply-To: <20120801203448.GX4483@opensource.wolfsonmicro.com>
References: <1343076052-27312-1-git-send-email-marex@denx.de>
 <1343076052-27312-9-git-send-email-marex@denx.de>
 <20120801203448.GX4483@opensource.wolfsonmicro.com>
Message-ID: <201208021700.43159.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mark Brown,

> On Mon, Jul 23, 2012 at 10:40:50PM +0200, Marek Vasut wrote:
> > +		/*
> > +		 * Small blocks can be transfered via PIO.
> > +		 * Measured by empiric means:
> > +		 *
> > +		 * dd if=/dev/mtdblock0 of=/dev/null bs=1024k count=1
> > +		 *
> > +		 * DMA only: 2.164808 seconds, 473.0KB/s
> > +		 * Combined: 1.676276 seconds, 610.9KB/s
> > +		 */
> 
> I've seen other devices end up using the FIFO length as the decision
> point here which makes intuitive sense to me unless the FIFO is
> extremely deep.

Yep, that's all good. This device has not too deep FIFO, but the reason I chose 
not to go that way is because the DMA allocations have some overhead too and 
this values seemed to be the best.

> Not reviewed this properly yet but it looks OK from a first read
> through.

Thanks!

Best regards,
Marek Vasut
