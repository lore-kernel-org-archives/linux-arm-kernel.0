From: vinod.koul@intel.com (Koul, Vinod)
Date: Thu, 26 May 2011 17:55:30 +0530
Subject: [PATCH 2/2] dmaengine: add TODO items for future work on dma
	drivers
In-Reply-To: <20110526073620.GF24876@n2100.arm.linux.org.uk>
References: <1306323570-11133-1-git-send-email-vinod.koul@intel.com>
	<1306323570-11133-3-git-send-email-vinod.koul@intel.com>
	<20110526073620.GF24876@n2100.arm.linux.org.uk>
Message-ID: <1306412730.2230.0.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-05-26 at 13:06 +0530, Russell King - ARM Linux wrote:
> On Wed, May 25, 2011 at 05:09:30PM +0530, Koul, Vinod wrote:
> > +1. Move remaining drivers to use new slave interface
> > +2. Remove old slave pointer machansim
> > +3. Make issue_pending to start the transaction in below drivers
> > +	- mpc512x_dma
> > +	- imx-dma
> > +	- imx-sdma
> > +	- mxs-dma.c
> > +	- dw_dmac
> > +	- intel_mid_dma
> > +	- ste_dma40
> 
> I'd suggest adding some more to this:
> 
> 4. Remove dma_slave_config's dma direction.
> 
> It's pointless that dma_slave_config carries the DMA direction (to/from
> device) and the prepare function does too.  It leads to DMA engine drivers
> having to verify that the two match, and DMA engine users having to issue
> two calls every time they change direction.
> 
> Instead, lets specify that dma_slave_config carries the _device_ side
> parameters, which are selected according to the direction given to the
> prepare function.  The memory-side parameters should be selected by the
> DMA engine driver according to its knowledge of the system.
> 
> This is sensible as M2M transfers don't allow configuration and therefore
> already have to select these parameters internally.
Sure, I am adding this as well and applying both patches

Thanks
-- 
~Vinod
