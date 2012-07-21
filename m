From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 21 Jul 2012 14:44:06 +0200
Subject: [PATCH 2/2 V3] MXS: Implement DMA support into mxs-i2c
In-Reply-To: <20120715081715.GA2429@S2100-06.ap.freescale.net>
References: <1341850974-11977-1-git-send-email-marex@denx.de>
 <1341850974-11977-2-git-send-email-marex@denx.de>
 <20120713082249.GF32184@pengutronix.de>
 <20120715081715.GA2429@S2100-06.ap.freescale.net>
Message-ID: <20120721124406.GA9946@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 15, 2012 at 04:17:16PM +0800, Shawn Guo wrote:
> On Fri, Jul 13, 2012 at 10:22:49AM +0200, Wolfram Sang wrote:
> > > +	/*
> > > +	 * TODO: This is a temporary solution and should be changed
> > > +	 * to use generic DMA binding later when the helpers get in.
> > > +	 */
> > 
> > @Shawn: Any idea when this is going to happen? And why do we need this?
> 
> See thread [1] for current statues.  I'm not sure when it's going to
> happen though.

Phew, [1] is a bit too much too read. I will just assume there are still
issues.

> > AFAICT it will be always channel 6/7 on mx28?
> > 
> Yes, but it might be a different channel on mx23.  Just like we define
> IO region and interrupt number in device tree, dma channel is just
> another resource of hardware block that we choose to define in device
> tree.

What makes me wonder now that I come to think of it (not necessarily a
question for Shawn but to all):

If I have an I2C slave with an interrupt line tied to something, GPIO or
external IRQ from the SoC, it makes perfect sense to define that in the
devicetree.

Yet, if I know the compatible property for the mxs I2C driver, and also
know the CPU type (be it MX23 or MX28), I can deduce from that a lot of
information, including DMA channel. That is fix. Why encode it?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120721/bd4e8ae8/attachment.sig>
