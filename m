From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 3 Oct 2013 20:43:32 +0530
Subject: [[PATCH] 0/3] imx-dma: fixes
In-Reply-To: <1379426168-31989-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1379426168-31989-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <20131003151332.GF16684@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 03:56:05PM +0200, Michael Grzeschik wrote:
> Hello,
> 
> this series is solving some lockdep issues in the imx-dma code.
> There are some list_head and deadlock issues in the code,
> that is running the implementation into unsafe situations.

Thanks a bunch for doing this. I had similar ones but couldnt test due to lack
of HW. Lets keep improving this driver as it needs bunch of other fixes too...

~Vinod
> 
> Regards,
> Michael
> 
> Michael Grzeschik (3):
>   dma: imx-dma: fix slow path issue in prep_dma_cyclic
>   dma: imx-dma: fix lockdep issue between irqhandler and tasklet
>   dma: imx-dma: fix callback path in tasklet
> 
>  drivers/dma/imx-dma.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
> -- 
> 1.8.4.rc3
> 

-- 
