From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 23 Sep 2013 09:49:53 +0530
Subject: [[PATCH] 0/3] imx-dma: fixes
In-Reply-To: <1379426168-31989-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1379426168-31989-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <20130923041953.GA17188@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 03:56:05PM +0200, Michael Grzeschik wrote:
> Hello,
> 
> this series is solving some lockdep issues in the imx-dma code.
> There are some list_head and deadlock issues in the code,
> that is running the implementation into unsafe situations.
Thanks for this, I have trying to fix this with testing done by Christoph. I had
similar set of fixes

Christoph can you pls try runnning this on your setup and check and we can apply
these

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
