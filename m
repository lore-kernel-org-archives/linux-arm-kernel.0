From: vinod.koul@intel.com (Koul, Vinod)
Date: Thu, 03 Mar 2011 00:04:15 +0530
Subject: [PATCH 6/8 resend] dw_dmac: Mark all tx_descriptors with
	DMA_CRTL_ACK after xfer finish
In-Reply-To: <82027aa0c6446df3f7fb8e3c5fbdc28f60ea33b7.1298889267.git.viresh.kumar@st.com>
References: <cover.1298889267.git.viresh.kumar@st.com>
	<82027aa0c6446df3f7fb8e3c5fbdc28f60ea33b7.1298889267.git.viresh.kumar@st.com>
Message-ID: <1299090855.6974.94.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-02-28 at 16:11 +0530, Viresh Kumar wrote:
> dwc_desc_get checks all descriptors for DMA_CTRL_ACK before allocating them for
> transfers. And descriptors are not marked with DMA_CRTL_ACK after transfer
> finishes. Thus descriptor once used is not usable again. This patch marks
> descriptors with DMA_CRTL_ACK after dma xfer finishes
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/dma/dw_dmac.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
> index c40b89f..01f783d 100644
> --- a/drivers/dma/dw_dmac.c
> +++ b/drivers/dma/dw_dmac.c
> @@ -196,6 +196,7 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc)
>  	dma_async_tx_callback		callback;
>  	void				*param;
>  	struct dma_async_tx_descriptor	*txd = &desc->txd;
> +	struct dw_desc	*child;
Please align this with previous ones....

-- 
~Vinod
