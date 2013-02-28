From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Feb 2013 16:28:33 +0800
Subject: [PATCH 04/12] mmc: mxs-mmc: move to use generic DMA helper
In-Reply-To: <201302272054.18829.arnd@arndb.de>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
 <1361978748-25281-5-git-send-email-shawn.guo@linaro.org>
 <201302272054.18829.arnd@arndb.de>
Message-ID: <20130228082831.GG26106@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 08:54:18PM +0000, Arnd Bergmann wrote:
> On Wednesday 27 February 2013, Shawn Guo wrote:
> >  Required properties:
> >  - compatible: Should be "fsl,<chip>-mmc".  The supported chips include
> >    imx23 and imx28.
> > -- interrupts: Should contain ERROR and DMA interrupts
> > -- fsl,ssp-dma-channel: APBH DMA channel for the SSP
> > +- interrupts: Should contain ERROR interrupt number
> > +- dmas: DMA specifier, consisting of a phandle to DMA controller node
> > +  and SSP DMA channel ID.
> > +  Refer to dma.txt and fsl-mxs-dma.txt for details.
> 
> I wonder if we should leave support for old device trees files around,
> at least for a while. Your patch removes a lot of unnecessary code if
> we decide not to worry about backwards compatibility here, but I could
> imagine that we see a few surprises here.
> 
I'm less concerned by that at this point.  Though platform mxs has been
fully converted to device tree, device tree is still quite new for the
platform.  The incompatible device tree should be acceptable,
considering we have noticed that when adding the temporary DMA binding
for client devices.

/*
 * TODO: This is a temporary solution and should be changed
 * to use generic DMA binding later when the helper get in.
 */

Unless we have these TODO remarks leave in the tree forever, we will
break old device tree sooner or later anyway.  And I would have it
happen sooner than later.

And I would start thinking about maintaining the device tree
compatibility for mxs after generic DMA binding adoption.

> > +- dma-names: Must be "ssp".
> 
> I would prefer calling this "data" rather than "ssp". The name only
> has local significance in the ssp device, so calling the channel
> "ssp" seems wrong.
> 
Ok, will rename it per the use of the channel in the controller.

Shawn
