From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Wed, 15 Dec 2010 17:45:58 +0530
Subject: [PATCH v1 3/9] OMAP2420: hwmod data: add system DMA]
In-Reply-To: <20101215110917.GD11931@GLPP-machine>
References: <1291434246-30716-1-git-send-email-manjugk@ti.com>
	<1291434246-30716-4-git-send-email-manjugk@ti.com>
	<alpine.DEB.2.00.1012141922550.15971@utopia.booyaka.com>
	<20101215110917.GD11931@GLPP-machine>
Message-ID: <20101215121558.GE11931@GLPP-machine>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 15, 2010 at 04:39:17PM +0530, G, Manjunath Kondaiah wrote:
> On Tue, Dec 14, 2010 at 07:25:23PM -0700, Paul Walmsley wrote:
> > Manju
> > 
> > On Sat, 4 Dec 2010, G, Manjunath Kondaiah wrote:
> > 
> > > Add OMAP2420 DMA hwmod data and also add required
> > > DMA device attributes.
> > > 
> > > Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> > > Cc: Benoit Cousson <b-cousson@ti.com>
> > > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > >
> > > +/* dma_system -> L3 */
> > > +static struct omap_hwmod_ocp_if omap2420_dma_system__l3 = {
> > > +	.master		= &omap2420_dma_system_hwmod,
> > > +	.slave		= &omap2420_l3_main_hwmod,
> > > +	.clk		= "l3_div_ck",
> > 
> > This clock does not exist on OMAP2420.  Did you test this patch on 2420?
> 
> ok. will be replaced with "sdma_ick". I don't have 2420 for testing. I
> tested it on 2430. My understanding is that, DMA clock interface is same
> for 2420 and 2430. Correct me if am wrong.

Looking into omap3/omap4 structures, this entry takes core l3 clock.

This should be "sdma_fck" since it's parent is core_l3_ck.

Pls confirm.

-Manjunath
