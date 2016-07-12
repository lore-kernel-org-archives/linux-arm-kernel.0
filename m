From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 12 Jul 2016 10:05:16 +0530
Subject: [PATCH] dmaengine: pxa_dma: implement device_synchronize
In-Reply-To: <1468187449-19466-1-git-send-email-robert.jarzmik@free.fr>
References: <1468187449-19466-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20160712043516.GP9681@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 10, 2016 at 11:50:49PM +0200, Robert Jarzmik wrote:
> Implement the function which wait until a dma channel is stopped to have
> a synchronization point.
> 
> This also protects the pxad_remove() from races, such as spurious
> interrupts while removing the driver, because :
>  - as long as there is one dma channel requested, ie. dma_chan_get() but
>    no dma_chan_put(), the try_module_get() of dma_chan_get() prevents
>    the remove() routine from running
>  - when the last channel is released, ie. the last dma_chan_put() is
>    called, if there is a running DMA, pxad_synchronize() is called
>  - pxad_synchronize() waits for the channel to stop, which in turn
>    ensures on pxa architecture that the interrupt cannot be fired anymore

Applied, thanks

-- 
~Vinod
