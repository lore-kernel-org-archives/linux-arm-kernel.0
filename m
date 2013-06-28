From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Jun 2013 16:32:43 +0200
Subject: [PATCH v2 1/2] dmaengine: add interface of dma_get_slave_channel
In-Reply-To: <1372423153-6742-2-git-send-email-zhangfei.gao@linaro.org>
References: <1372423153-6742-1-git-send-email-zhangfei.gao@linaro.org>
 <1372423153-6742-2-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <201306281632.43409.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 June 2013, Zhangfei Gao wrote:
> Suggested by Arnd, add dma_get_slave_channel interface
> Dma host driver could get specific channel specificied by request line, rather than filter.
> 
> host example:
> static struct dma_chan *xx_of_dma_simple_xlate(struct of_phandle_args *dma_spec,
>                 struct of_dma *ofdma)
> {
>         struct xx_dma_dev *d = ofdma->of_dma_data;
>         unsigned int request = dma_spec->args[0];
> 
>         if (request > d->dma_requests)
>                 return NULL;
> 
>         return dma_get_slave_channel(&(d->chans[request].vc.chan));
> }
> 
> probe:
> of_dma_controller_register((&op->dev)->of_node, xx_of_dma_simple_xlate, d);
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
