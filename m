From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 13 Aug 2013 16:34:36 +0530
Subject: [PATCH v2 1/2] dmaengine: add interface of dma_get_slave_channel
In-Reply-To: <1372423153-6742-2-git-send-email-zhangfei.gao@linaro.org>
References: <1372423153-6742-1-git-send-email-zhangfei.gao@linaro.org>
 <1372423153-6742-2-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20130813110435.GA32147@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 08:39:12PM +0800, Zhangfei Gao wrote:
> Suggested by Arnd, add dma_get_slave_channel interface
> Dma host driver could get specific channel specificied by request line, rather than filter.
> 
> host example:
> static struct dma_chan *xx_of_dma_simple_xlate(struct of_phandle_args *dma_spec,
> 		struct of_dma *ofdma)
> {
> 	struct xx_dma_dev *d = ofdma->of_dma_data;
> 	unsigned int request = dma_spec->args[0];
> 
> 	if (request > d->dma_requests)
> 		return NULL;
> 
> 	return dma_get_slave_channel(&(d->chans[request].vc.chan));
> }
> 
> probe:
> of_dma_controller_register((&op->dev)->of_node, xx_of_dma_simple_xlate, d);
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Applied, thanks

~Vinod
