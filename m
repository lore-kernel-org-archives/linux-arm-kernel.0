From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Fri, 13 Sep 2013 10:19:14 +0000
Subject: [PATCH v5 3/3] dma: Add Freescale eDMA engine driver support
In-Reply-To: <1378374902-16512-1-git-send-email-b35083@freescale.com>
References: <1378374902-16512-1-git-send-email-b35083@freescale.com>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E852227D5@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Vinod,

  Could you please help review this patch? 
  Thanks!


Best Regards,
Jingchang

> -----Original Message-----
> From: Lu Jingchang-B35083
> Sent: Thursday, September 05, 2013 5:55 PM
> To: vinod.koul at intel.com
> Cc: djbw at fb.com; shawn.guo at linaro.org; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org; Lu
> Jingchang-B35083; Wang Huan-B18965
> Subject: [PATCH v5 3/3] dma: Add Freescale eDMA engine driver support
> 
> Add Freescale enhanced direct memory(eDMA) controller support.
> The eDMA controller deploys DMAMUXs routing DMA request sources(slot)
> to eDMA channels.
> This module can be found on Vybrid and LS-1 SoCs.
> 
> Signed-off-by: Alison Wang <b18965@freescale.com>
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
> changes in v5:
>   config slave_id when dmaengine_slave_config intead of channel request.
>   adding residue calculation and dma pause/resume device control.
> 
> changes in v4:
>   using exact compatible string in binding document.
> 
> changes in v3:
>   handle all pending interrupt one time.
>   add protect lock on dma transfer complete handling.
>   change desc and tcd alloc flag to GFP_NOWAIT.
>   add sanity check and error messages.
> 
> changes in v2:
>   using generic dma-channels property instead of fsl,dma-channel.
>   rename the binding document to fsl-edma.txt.
> 
>  Documentation/devicetree/bindings/dma/fsl-edma.txt |  84 ++
>  drivers/dma/Kconfig                                |  10 +
>  drivers/dma/Makefile                               |   1 +
>  drivers/dma/fsl-edma.c                             | 925
> +++++++++++++++++++++
>  4 files changed, 1020 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/fsl-edma.txt
>  create mode 100644 drivers/dma/fsl-edma.c
> 
