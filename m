From: marex@denx.de (Marek Vasut)
Date: Tue, 14 Jan 2014 23:25:40 +0100
Subject: [PATCH v2 1/2] spi: spi-imx: enable dma support for escpi
 controller
In-Reply-To: <20140114221315.GE15567@sirena.org.uk>
References: <1388789632-12238-1-git-send-email-Frank.Li@freescale.com>
 <201401142302.31434.marex@denx.de> <20140114221315.GE15567@sirena.org.uk>
Message-ID: <201401142325.40943.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 14, 2014 at 11:13:15 PM, Mark Brown wrote:
> On Tue, Jan 14, 2014 at 11:02:31PM +0100, Marek Vasut wrote:
> > On Tuesday, January 14, 2014 at 10:55:48 PM, Mark Brown wrote:
> > > Or try to - the other trick here is getting 4MB of contiguous memory in
> > > the first place (unless there's an IOMMU making everything pretty).
> > 
> > Oh, but what if I want to make a really looong transfer ? Say, read
> > entire SPI NOR of 128MB in size ... Spansion has such big SPI NORs in
> > their new portfolio.
> 
> Use scatter/gather - to the SPI controller and the outside world it
> still looks like one big transfer (I'm missing a way to go from a
> virtual address to a sg_list, that'd be handy).  It's an issue if the
> DMA controller doesn't support it but but that's rare.

OK, yep, indeed.

Best regards,
Marek Vasut
