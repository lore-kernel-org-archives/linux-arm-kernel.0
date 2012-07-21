From: marex@denx.de (Marek Vasut)
Date: Sat, 21 Jul 2012 16:11:58 +0200
Subject: [PATCH 2/2 V3] MXS: Implement DMA support into mxs-i2c
In-Reply-To: <20120721124406.GA9946@pengutronix.de>
References: <1341850974-11977-1-git-send-email-marex@denx.de>
 <20120715081715.GA2429@S2100-06.ap.freescale.net>
 <20120721124406.GA9946@pengutronix.de>
Message-ID: <201207211611.58956.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wolfram Sang,

> On Sun, Jul 15, 2012 at 04:17:16PM +0800, Shawn Guo wrote:
> > On Fri, Jul 13, 2012 at 10:22:49AM +0200, Wolfram Sang wrote:
> > > > +	/*
> > > > +	 * TODO: This is a temporary solution and should be changed
> > > > +	 * to use generic DMA binding later when the helpers get in.
> > > > +	 */
> > > 
> > > @Shawn: Any idea when this is going to happen? And why do we need this?
> > 
> > See thread [1] for current statues.  I'm not sure when it's going to
> > happen though.
> 
> Phew, [1] is a bit too much too read. I will just assume there are still
> issues.
> 
> > > AFAICT it will be always channel 6/7 on mx28?
> > 
> > Yes, but it might be a different channel on mx23.  Just like we define
> > IO region and interrupt number in device tree, dma channel is just
> > another resource of hardware block that we choose to define in device
> > tree.
> 
> What makes me wonder now that I come to think of it (not necessarily a
> question for Shawn but to all):
> 
> If I have an I2C slave with an interrupt line tied to something, GPIO or
> external IRQ from the SoC, it makes perfect sense to define that in the
> devicetree.
> 
> Yet, if I know the compatible property for the mxs I2C driver, and also
> know the CPU type (be it MX23 or MX28), I can deduce from that a lot of
> information, including DMA channel. That is fix. Why encode it?

You know the compatible and the "fallback compatible". From the later one, you 
can deduce nothing if that happens to kick in.

btw. the PIO discussion on DT discuss is completely ignored. How shall we 
proceed, this driver is stalled for too long.

> Regards,
> 
>    Wolfram

Best regards,
Marek Vasut
