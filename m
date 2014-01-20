From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Jan 2014 19:41:07 +0100
Subject: [PATCH] dma: Add Xilinx AXI Video Direct Memory Access Engine
 driver support
In-Reply-To: <CA+mB=1+mrWAzBCxdMEji2MDRzHajmnxuWtz7iu96ML0DuAB3RQ@mail.gmail.com>
References: <1389894803-4147-1-git-send-email-sthokal@xilinx.com>
 <201401201239.47665.arnd@arndb.de>
 <CA+mB=1+mrWAzBCxdMEji2MDRzHajmnxuWtz7iu96ML0DuAB3RQ@mail.gmail.com>
Message-ID: <201401201941.07633.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 January 2014, Srikanth Thokala wrote:
> >
> >> > * data width should be a property of the slave driver that is configured
> >> >   through dma_slave_config(), unless you can have dma engines that only
> >> >   support certain a width.
> >>
> >> Yes, this VDMA engine soft IP support only certain widths, which is
> >> configurable during IP synthesis.
> >
> > But what is this property used for in that case? Surely you can't
> > connect a slave device to a dmaengine if the bus width doesn't match.
> > You probably have a point here, but I don't understand it yet.
> 
> There is a Data-Realignment Engine (DRE) in the IP which is only available for
> data width setting of 64-bits and less.  So, we use the data-width DT parameter
> to verify this condition and we update alignment shift accordingly.

Ok, I have to admit I didn't understand all of that, but you clearly
know what you are talking about here, so I assume you are correct.

	Arnd
