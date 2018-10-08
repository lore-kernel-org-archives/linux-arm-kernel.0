From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 8 Oct 2018 20:26:53 +0200
Subject: [PATCH] dmaengine: owl: Fix warnings generated during build
In-Reply-To: <20181008171631.5603-1-manivannan.sadhasivam@linaro.org>
References: <20181008171631.5603-1-manivannan.sadhasivam@linaro.org>
Message-ID: <411d45f8-6024-925e-ffde-f65351b3a09a@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 08.10.18 um 19:16 schrieb Manivannan Sadhasivam:
> Following warnings are generated when compiled with W=1,
> 
> drivers/dma/owl-dma.c:170: warning: Function parameter or member 'cyclic'
> not described in 'owl_dma_txd'
> drivers/dma/owl-dma.c:198: warning: Function parameter or member 'cfg' not
> described in 'owl_dma_vchan'
> drivers/dma/owl-dma.c:198: warning: Function parameter or member 'drq' not
> described in 'owl_dma_vchan'
> drivers/dma/owl-dma.c:225: warning: Function parameter or member 'irq' not
> described in 'owl_dma'
> 
> Fix this by adding comments for relevant struct members to appear in
> kernel-doc.
> 
> Fixes: d64e1b3f5cce ("dmaengine: owl: Add Slave and Cyclic mode support for
> Actions Semi Owl S900 SoC")

If possible, one line please, and it could go between Reported-by and
Signed-off-by below without extra white lines.

Otherwise looks okay,
Reviewed-by: Andreas F?rber <afaerber@suse.de>

Thanks,
Andreas

> 
> Reported-by: Vinod Koul <vinod.koul@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/dma/owl-dma.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
> index 1d26db4c9229..90bbcef99ef8 100644
> --- a/drivers/dma/owl-dma.c
> +++ b/drivers/dma/owl-dma.c
> @@ -162,6 +162,7 @@ struct owl_dma_lli {
>   * struct owl_dma_txd - Wrapper for struct dma_async_tx_descriptor
>   * @vd: virtual DMA descriptor
>   * @lli_list: link list of lli nodes
> + * @cyclic: flag to indicate cyclic transfers
>   */
>  struct owl_dma_txd {
>  	struct virt_dma_desc	vd;
> @@ -188,6 +189,8 @@ struct owl_dma_pchan {
>   * @vc: wrappped virtual channel
>   * @pchan: the physical channel utilized by this channel
>   * @txd: active transaction on this channel
> + * @cfg: slave configuration for this channel
> + * @drq: physical DMA request ID for this channel
>   */
>  struct owl_dma_vchan {
>  	struct virt_dma_chan	vc;
> @@ -204,6 +207,7 @@ struct owl_dma_vchan {
>   * @clk: clock for the DMA controller
>   * @lock: a lock to use when change DMA controller global register
>   * @lli_pool: a pool for the LLI descriptors
> + * @irq: interrupt ID for the DMA controller
>   * @nr_pchans: the number of physical channels
>   * @pchans: array of data for the physical channels
>   * @nr_vchans: the number of physical channels
> 


-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
