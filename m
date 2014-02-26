From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 26 Feb 2014 22:19:49 +0800
Subject: [PATCH 1/3] Documentation:spi:fsl-dspi:add DSPI dma transfer
 support
In-Reply-To: <20140225090830.GO28555@e106331-lin.cambridge.arm.com>
References: <1393311258-14380-1-git-send-email-b44548@freescale.com>
 <20140225090830.GO28555@e106331-lin.cambridge.arm.com>
Message-ID: <20140226141947.GE23892@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 09:08:30AM +0000, Mark Rutland wrote:
> On Tue, Feb 25, 2014 at 06:54:16AM +0000, Chao Fu wrote:
> > From: Chao Fu <B44548@freescale.com>
> > 
> > Add bool value use-dma.
> > The bool will determine whether DSPI use dma channel transfer data
> > in a platform.
> > 
> > Add dmas and dma-names for describing dma channels of DSPI.
> > 
> > Signed-off-by: Chao Fu      <b44548@freescale.com>
> > ---
> >  Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> > index 5376de4..76a1039 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> > +++ b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> > @@ -11,6 +11,11 @@ Required properties:
> >  - spi-num-chipselects : the number of the chipselect signals.
> >  - bus-num : the slave chip chipselect signal number.
> >  - big-endian : if DSPI modudle is big endian, the bool will be set in node.
> > +- use-dma: the bool decide if use dma method in DSPI transfering.
> 
> Why can the OS not decide this based on the presence of dmas which it
> can use?

Yes, OS/driver should decide to use DMA or not, but it shouldn't be
based on the presence of 'dmas' property.  The DMA is a hardware
resource just like IRQ.  It should be just there in client device's node
as long as the SoC design assigns the channel to the device.  The device
driver should make the decision when DMA should be used, e.g. big amount
data transfer, and when PIO should be used, e.g. small data.

Shawn

> 
> Is there ever a case that there would be dmas present but it would be in
> the interests of the OS to not use them?
