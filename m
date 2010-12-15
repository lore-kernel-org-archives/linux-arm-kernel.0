From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Wed, 15 Dec 2010 21:23:33 +0530
Subject: [PATCH v1 4/9] OMAP2430: hwmod data: add system DMA
In-Reply-To: <alpine.DEB.2.00.1012150814250.15971@utopia.booyaka.com>
References: <1291434246-30716-1-git-send-email-manjugk@ti.com>
	<1291434246-30716-5-git-send-email-manjugk@ti.com>
	<alpine.DEB.2.00.1012141925300.15971@utopia.booyaka.com>
	<20101215105953.GC11931@GLPP-machine>
	<alpine.DEB.2.00.1012150814250.15971@utopia.booyaka.com>
Message-ID: <20101215155333.GA28354@GLPP-machine>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 15, 2010 at 08:14:49AM -0700, Paul Walmsley wrote:
> On Wed, 15 Dec 2010, G, Manjunath Kondaiah wrote:
> 
> > On Tue, Dec 14, 2010 at 07:27:33PM -0700, Paul Walmsley wrote:
> > > On Sat, 4 Dec 2010, G, Manjunath Kondaiah wrote:
> > > 
> > > > Add OMAP2430 DMA hwmod data and also add required
> > > > DMA device attributes.
> > > 
> > > ...
> > > 
> > > > +/* dma_system -> L3 */
> > > > +static struct omap_hwmod_ocp_if omap2430_dma_system__l3 = {
> > > > +	.master		= &omap2430_dma_system_hwmod,
> > > > +	.slave		= &omap2430_l3_main_hwmod,
> > > > +	.clk		= "l3_div_ck",
> > > 
> > > This clock does not exist on OMAP2430.  Did you test this on OMAP2430?
> > 
> > Yes. I have tested this on SDP2430. For confirmation, I tested again now.
> > It boots up without any issues and all DMA test cases are passing.
> 
> Don't you see warnings in the boot messages that this clock cannot be 
> found?

No. I don't see any warnings in boot log. May missing during early
prints?

-Manjunath
