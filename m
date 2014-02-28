From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 28 Feb 2014 10:23:52 +0800
Subject: [PATCH 1/3] i2c: add DMA support for freescale i2c driver
In-Reply-To: <20140228021300.GJ13537@S2101-09.ap.freescale.net>
References: <1393481115-22136-1-git-send-email-yao.yuan@freescale.com>
 <1393481115-22136-2-git-send-email-yao.yuan@freescale.com>
 <201402272139.36076.marex@denx.de>
 <20140228021300.GJ13537@S2101-09.ap.freescale.net>
Message-ID: <20140228022348.GB28660@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 10:13:02AM +0800, Shawn Guo wrote:
> On Thu, Feb 27, 2014 at 09:39:35PM +0100, Marek Vasut wrote:
> > > @@ -193,6 +216,7 @@ static const struct imx_i2c_hwdata imx1_i2c_hwdata  = {
> > >  	.ndivs			= ARRAY_SIZE(imx_i2c_clk_div),
> > >  	.i2sr_clr_opcode	= I2SR_CLR_OPCODE_W0C,
> > >  	.i2cr_ien_opcode	= I2CR_IEN_OPCODE_1,
> > > +	.has_dma_support	= false,
> > > 
> > >  };
> > > 
> > > @@ -203,6 +227,7 @@ static const struct imx_i2c_hwdata imx21_i2c_hwdata  =
> > > { .ndivs			= ARRAY_SIZE(imx_i2c_clk_div),
> > >  	.i2sr_clr_opcode	= I2SR_CLR_OPCODE_W0C,
> > >  	.i2cr_ien_opcode	= I2CR_IEN_OPCODE_1,
> > > +	.has_dma_support	= false,
> > > 
> > >  };
> > > 
> > > @@ -213,6 +238,7 @@ static struct imx_i2c_hwdata vf610_i2c_hwdata = {
> > >  	.ndivs			= ARRAY_SIZE(vf610_i2c_clk_div),
> > >  	.i2sr_clr_opcode	= I2SR_CLR_OPCODE_W1C,
> > >  	.i2cr_ien_opcode	= I2CR_IEN_OPCODE_0,
> > > +	.has_dma_support	= true,
> > 
> > So why exactly don't we have a DT prop for determining whether the controller 
> > has DMA support ?
> 
> Using DMA or PIO is a decision that should be made by driver on its own,
> not device tree.

Sorry.  I misunderstood it.  Yes, we can look at the DT property 'dmas'
to know if the controller has DMA capability.

Shawn
