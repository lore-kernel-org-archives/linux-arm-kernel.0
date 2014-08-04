From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 4 Aug 2014 13:41:28 +0530
Subject: [PATCH] dmaengine: Remove the context argument to the
 prep_dma_cyclic operation
In-Reply-To: <20140801170633.GT30282@n2100.arm.linux.org.uk>
References: <1406888410-14504-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20140801164428.GB8181@intel.com>
 <20140801170633.GT30282@n2100.arm.linux.org.uk>
Message-ID: <20140804081128.GL8181@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 01, 2014 at 06:06:33PM +0100, Russell King - ARM Linux wrote:
> On Fri, Aug 01, 2014 at 10:14:28PM +0530, Vinod Koul wrote:
> > On Fri, Aug 01, 2014 at 12:20:10PM +0200, Laurent Pinchart wrote:
> > > The argument is always set to NULL and never used. Remove it.
> > 
> > Thats not true.
> > 
> > It was introduced in commit:
> > commit 185ecb5f4fd43911c35956d4cc7d94a1da30417f
> > Author: Alexandre Bounine <alexandre.bounine@idt.com>
> > Date:   Thu Mar 8 15:35:13 2012 -0500
> > 
> >     dmaengine: add context parameter to prep_slave_sg and prep_dma_cyclic
> > 
> >     Add context parameter to device_prep_slave_sg() and device_prep_dma_cyclic()
> >     interfaces to allow passing client/target specific information associated
> >     with the data transfer.
> >     Modify all affected DMA engine drivers.
> > 
> >     Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
> >     Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >     Acked-by: Felipe Balbi <balbi@ti.com>
> >     Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
> > 
> > This is still used by rapidio driver. This required some extra parameters
> > passed in struct rio_dma_ext.
> > 
> > I do agree this is not very elegant.
> 
> Have the rapidio folk shown any sign of implementing the cyclic DMA API?
> From what I can see from drivers/rapido/, it only uses the prep_slave_sg
> API.
No they havent so i think its good to remove the unused context argument. Will merge
this now

-- 
~Vinod
