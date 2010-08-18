From: philippe.retornaz@epfl.ch (Philippe =?iso-8859-1?q?R=E9tornaz?=)
Date: Wed, 18 Aug 2010 13:17:48 +0200
Subject: [PATCH 3/3] dmaengine: Add Freescale i.MX SDMA support
In-Reply-To: <20100817064734.GS27749@pengutronix.de>
References: <1281956870-12463-1-git-send-email-s.hauer@pengutronix.de>
	<20100817043612.GA9631@jasper.tkos.co.il>
	<20100817064734.GS27749@pengutronix.de>
Message-ID: <201008181317.48948.philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mardi, 17 ao?t 2010 08.47:34, Sascha Hauer a ?crit :
> On Tue, Aug 17, 2010 at 07:36:12AM +0300, Baruch Siach wrote:
> > Hi Sascha,
> >
> > On Mon, Aug 16, 2010 at 04:15:40PM +0200, Sascha Hauer wrote:
> > > On Mon, Aug 16, 2010 at 02:21:06PM +0200, Linus Walleij wrote:
> > > > 2010/8/16 Sascha Hauer <s.hauer@pengutronix.de>:
> > > > > The SDMA engine is a scatter/gather DMA engine which is implemented
> > > > > as a seperate coprocessor. SDMA needs its own firmware which is
> > > > > requested using the standard request_firmware mechanism. The
> > > > > firmware has different entry points for each peripheral type, so
> > > > > drivers have to pass the peripheral type to the DMA engine which in
> > > > > turn picks the correct firmware entry point from a table contained
> > > > > in the firmware image itself.
> > > >
> > > > Quite fun, if the spec for the microcode is open this opens up
> > > > for dynamic firmware generation for specific DMA jobs does it
> > > > not?
> > >
> > > Unfortunately the specs are not open, so we are sticked to the binary
> > > microcode from Freescale. I'm pretty sure though that the SDMA engine
> > > could do at least a device_prep_dma_xor operation.
> >
> > Chapter 38 in the i.MX25 Reference Manual seems to include almost
> > everything there is to know about the SDMA. Isn't this enough for writing
> > custom SDMA microcodes?
> 
> Unfortunately not, the assembler is missing.
> 

I think the instruction list and encoding is available in the imx31 reference 
manual at section 40.19.

BTW, I tested the non-dmaengine version of your patch on imx31, works great !

Regards,

Philippe
