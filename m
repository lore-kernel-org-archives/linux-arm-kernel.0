From: marex@denx.de (Marek Vasut)
Date: Fri, 28 Feb 2014 13:03:52 +0100
Subject: [PATCH 1/3] i2c: add DMA support for freescale i2c driver
In-Reply-To: <3d65fc9a0c5444b485c93de4087634e0@BL2PR03MB338.namprd03.prod.outlook.com>
References: <1393481115-22136-1-git-send-email-yao.yuan@freescale.com>
 <201402281004.10238.marex@denx.de>
 <3d65fc9a0c5444b485c93de4087634e0@BL2PR03MB338.namprd03.prod.outlook.com>
Message-ID: <201402281303.52962.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, February 28, 2014 at 12:36:01 PM, Yao Yuan wrote:
> Hi Marek,
> 
> > On Friday, February 28, 2014 at 06:19:18 AM, Yao Yuan wrote:
> > 
> > [...]
> > 
> > > > > @@ -213,6 +238,7 @@ static struct imx_i2c_hwdata vf610_i2c_hwdata
> > > > > = {
> > > > > 
> > > > >  	.ndivs			= ARRAY_SIZE(vf610_i2c_clk_div),
> > > > >  	.i2sr_clr_opcode	= I2SR_CLR_OPCODE_W1C,
> > > > >  	.i2cr_ien_opcode	= I2CR_IEN_OPCODE_0,
> > > > > 
> > > > > +	.has_dma_support	= true,
> > > > 
> > > > So why exactly don't we have a DT prop for determining whether the
> > > > controller has DMA support ?
> > > > 
> > > > What about the other controllers, do they not support DMA for some
> > > > specific reason? Please elaborate on that, thank you !
> > > 
> > > Sorry for my fault. I will modify it.
> > 
> > I would prefer if you could explain why other controllers do have DMA
> > disabled even if the hardware does support the DMA operation.
> 
> Well, Because of the I2C in I.MX hardware don't support the DMA operation.
> But here I also think has_dma_support isn't necessary.

OK, got it now. Thanks!

> > > > Also, can the DMA not do full-duplex operation ? What I see here is
> > > > just
> > > > half- duplex operations , one for RX and the other one for TX .
> > > 
> > > Yes, here have two dma channels, one for RX and the other one for TX.
> > > When we request the channel we should determine it for TX or RX.
> > 
> > Sorry, I don't quite understand this. If you have two DMA channels, can
> > you not use them both to do full-duplex SPI transfer ?
> 
> Sorry, There are also hard for me. I don't understand what is full-duplex
> for dma?

Sorry, nevermind. I was confused by this and some SPI patches review. Like 
Lothar (thanks!) pointed out, using only half-duplex operation is OK.

Best regards,
Marek Vasut
