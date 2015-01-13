From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 13 Jan 2015 20:12:57 +0530
Subject: [PATCH] dmaengine: k3: fix duplicate function definition
In-Reply-To: <1869934.MKKaD1UAQn@wuerfel>
References: <E1YAwSG-0000zm-Cs@debutante> <20150113120751.GQ4160@sirena.org.uk>
 <1869934.MKKaD1UAQn@wuerfel>
Message-ID: <20150113144257.GA3085@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 02:23:13PM +0100, Arnd Bergmann wrote:
> Commit db08425ebd51f ("dmaengine: k3: Split device_control") introduced
> two new helper functions, which unfortunately have the same names
> as the existing suspend/resume functions, resulting in a build error
> when CONFIG_PM_SLEEP is enabled:
> 
> drivers/dma/k3dma.c:823:12: error: conflicting types for 'k3_dma_resume'
>  static int k3_dma_resume(struct device *dev)
>             ^
> drivers/dma/k3dma.c:625:12: note: previous definition of 'k3_dma_resume' was here
>  static int k3_dma_resume(struct dma_chan *chan)
Applied, Thanks

-- 
~Vinod
