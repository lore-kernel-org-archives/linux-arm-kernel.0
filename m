From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 18 Jan 2015 20:02:26 +0530
Subject: [PATCH] dma: coh901318: fix function return types build warnings
In-Reply-To: <2760189.hGZZQd3ELS@wuerfel>
References: <2760189.hGZZQd3ELS@wuerfel>
Message-ID: <20150118143226.GQ15411@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 10:17:03PM +0100, Arnd Bergmann wrote:
> A recent patch that removed coh901318_control() replaced it
> with a number of pointers to existing functions, but those
> unfortunately have the wrong return  type and need to be
> changed to return an 'int' with an error value rather than
> a 'void' to avoid these build warnings:
> 
> drivers/dma/coh901318.c:2697:32: warning: assignment from incompatible pointer type
>   base->dma_slave.device_config = coh901318_dma_set_runtimeconfig;
>                                 ^
> drivers/dma/coh901318.c:2698:31: warning: assignment from incompatible pointer type
>   base->dma_slave.device_pause = coh901318_pause;
>                                ^
> drivers/dma/coh901318.c:2699:32: warning: assignment from incompatible pointer type
>   base->dma_slave.device_resume = coh901318_resume
> 
> The coh901318_base_init function has the correct return type
> already, but needs to be marked 'static' to avoid a sparse
> warning about a missing declaration.
> 
Please use the right subsystem name

Applied now

Thanks
-- 
~Vinod
