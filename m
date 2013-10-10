From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 10 Oct 2013 21:14:14 +0530
Subject: [PATCH v6 3/3] dma: Add Freescale eDMA engine driver support
In-Reply-To: <B56CDBE15CE27145A4B77D2D24263E8522EFE6@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1379498279-16096-1-git-send-email-b35083@freescale.com>
 <B56CDBE15CE27145A4B77D2D24263E8522EFE6@039-SN1MPN1-004.039d.mgd.msft.net>
Message-ID: <20131010154414.GY2954@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 10, 2013 at 09:39:04AM +0000, Lu Jingchang-B35083 wrote:
> Hi, Vinod,
> 
>   Could you please help review this patch? Could it be merged into your next tree?
>   Thanks!
Where is the patch 1 & 2 of the series, I dont sem to find it.
Also I need ACK from one of the DT maintainers on the binding before I can carry
this

--
~Vinod
> 
> 
> Best Regards,
> Jingchang
> 
> 
> > -----Original Message-----
> > From: Lu Jingchang-B35083
> > Sent: Wednesday, September 18, 2013 5:58 PM
> > To: vinod.koul at intel.com
> > Cc: shawn.guo at linaro.org; linux-kernel at vger.kernel.org; linux-arm-
> > kernel at lists.infradead.org; devicetree at vger.kernel.org; Lu Jingchang-
> > B35083; Wang Huan-B18965
> > Subject: [PATCH v6 3/3] dma: Add Freescale eDMA engine driver support
> > 
> > Add Freescale enhanced direct memory(eDMA) controller support.
> > The eDMA controller deploys DMAMUXs routing DMA request sources(slot)
> > to eDMA channels.
> > This module can be found on Vybrid and LS-1 SoCs.
> > 
> > Signed-off-by: Alison Wang <b18965@freescale.com>
> > Signed-off-by: Jingchang Lu <b35083@freescale.com>
> > ---
> > changes in v6:
> >   holding lock in dma_control to prevent race.
> > 
> > changes in v5:
> >   config slave_id when dmaengine_slave_config intead of channel request.
> >   adding residue calculation and dma pause/resume device control.
> > 
> > changes in v4:
> >   using exact compatible string in binding document.
> > 
> > changes in v3:
> >   handle all pending interrupt one time.
> >   add protect lock on dma transfer complete handling.
> >   change desc and tcd alloc flag to GFP_NOWAIT.
> >   add sanity check and error messages.
> > 
> > changes in v2:
> >   using generic dma-channels property instead of fsl,dma-channel.
> >   rename the binding document to fsl-edma.txt.
> > 
> > 
> >  Documentation/devicetree/bindings/dma/fsl-edma.txt |  84 ++
> >  drivers/dma/Kconfig                                |  10 +
> >  drivers/dma/Makefile                               |   1 +
> >  drivers/dma/fsl-edma.c                             | 944
> > +++++++++++++++++++++
> >  4 files changed, 1039 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/fsl-edma.txt
> >  create mode 100644 drivers/dma/fsl-edma.c
> 

-- 
