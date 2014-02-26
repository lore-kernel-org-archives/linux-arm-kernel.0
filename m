From: broonie@kernel.org (Mark Brown)
Date: Thu, 27 Feb 2014 00:38:22 +0900
Subject: [PATCH 1/3] Documentation:spi:fsl-dspi:add DSPI dma transfer
 support
In-Reply-To: <20140226141947.GE23892@S2101-09.ap.freescale.net>
References: <1393311258-14380-1-git-send-email-b44548@freescale.com>
 <20140225090830.GO28555@e106331-lin.cambridge.arm.com>
 <20140226141947.GE23892@S2101-09.ap.freescale.net>
Message-ID: <20140226153822.GC2394@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 10:19:49PM +0800, Shawn Guo wrote:
> On Tue, Feb 25, 2014 at 09:08:30AM +0000, Mark Rutland wrote:

> > > +- use-dma: the bool decide if use dma method in DSPI transfering.

> > Why can the OS not decide this based on the presence of dmas which it
> > can use?

> Yes, OS/driver should decide to use DMA or not, but it shouldn't be
> based on the presence of 'dmas' property.  The DMA is a hardware
> resource just like IRQ.  It should be just there in client device's node
> as long as the SoC design assigns the channel to the device.  The device
> driver should make the decision when DMA should be used, e.g. big amount
> data transfer, and when PIO should be used, e.g. small data.

Right, that's very common - but that decision is usually taken on a per
transfer basis so a DT property would seem odd, especially just a simple
boolean.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140227/898f98b9/attachment.sig>
