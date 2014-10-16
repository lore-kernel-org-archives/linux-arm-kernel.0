From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 16 Oct 2014 14:33:46 +0530
Subject: [PATCH 00/11] dmaengine: Cleanup chancnt
In-Reply-To: <1413450063-23829-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413450063-23829-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20141016090346.GE1638@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 16, 2014 at 11:00:52AM +0200, Maxime Ripard wrote:
> Hi everyone,
> 
> As pointed out in the documentation thread [1], the chancnt variable
> is filled during the driver registration in dma_async_device_register,
> from the liste of channels that has been set.
> 
> This serie removes the occurences of the drivers that set it in their
> probe function.
Barring the typos in the cover letter, series looks fine.


Thanks
-- 
~Vinod
> 
> Maxime
> 
> 
> 1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/292941.html
> 
> Maxime Ripard (11):
>   dmaengine: pl08x: Remove chancnt affectations
>   dmaengine: bcm2835: Remove chancnt affectations
>   dmaengine: jz4740: Remove chancnt affectations
>   dmaengine: fsldma: Remove chancnt affectations
>   dmaengine: k3: Remove chancnt affectations
>   dmaengine: mpc512x: Remove chancnt affectations
>   dmaengine: omap: Remove chancnt affectations
>   dmaengine: sa11x0: Remove chancnt affectations
>   dmaengine: sh: Remove chancnt affectations
>   dmaengine: sirf: Remove chancnt affectations
>   dmaengine: sun6i: Remove chancnt affectations
> 
>  drivers/dma/amba-pl08x.c      |  2 --
>  drivers/dma/bcm2835-dma.c     |  2 --
>  drivers/dma/dma-jz4740.c      |  3 +--
>  drivers/dma/fsldma.c          |  1 -
>  drivers/dma/k3dma.c           |  1 -
>  drivers/dma/mpc512x_dma.c     | 12 +++++++-----
>  drivers/dma/omap-dma.c        |  2 --
>  drivers/dma/sa11x0-dma.c      |  3 +--
>  drivers/dma/sh/rcar-audmapp.c |  2 --
>  drivers/dma/sh/rcar-hpbdma.c  |  2 --
>  drivers/dma/sh/shdma-base.c   |  2 +-
>  drivers/dma/sh/shdmac.c       |  2 --
>  drivers/dma/sh/sudmac.c       |  2 --
>  drivers/dma/sirf-dma.c        |  3 +--
>  drivers/dma/sun6i-dma.c       |  1 -
>  15 files changed, 11 insertions(+), 29 deletions(-)
> 
> -- 
> 2.1.1
> 

-- 
