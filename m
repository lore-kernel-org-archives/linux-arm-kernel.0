From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 28 Feb 2011 15:05:24 +0300
Subject: [PATCH 6/8 resend] dw_dmac: Mark all tx_descriptors with
	DMA_CRTL_ACK after xfer finish
In-Reply-To: <82027aa0c6446df3f7fb8e3c5fbdc28f60ea33b7.1298889267.git.viresh.kumar@st.com>
References: <cover.1298889267.git.viresh.kumar@st.com>
	<82027aa0c6446df3f7fb8e3c5fbdc28f60ea33b7.1298889267.git.viresh.kumar@st.com>
Message-ID: <4D6B8F84.40905@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 28-02-2011 13:41, Viresh Kumar wrote:

> dwc_desc_get checks all descriptors for DMA_CTRL_ACK before allocating them for
> transfers. And descriptors are not marked with DMA_CRTL_ACK after transfer
> finishes. Thus descriptor once used is not usable again. This patch marks
> descriptors with DMA_CRTL_ACK after dma xfer finishes

> Signed-off-by: Viresh Kumar<viresh.kumar@st.com>
> ---
>   drivers/dma/dw_dmac.c |    7 +++++++
>   1 files changed, 7 insertions(+), 0 deletions(-)

> diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
> index c40b89f..01f783d 100644
> --- a/drivers/dma/dw_dmac.c
> +++ b/drivers/dma/dw_dmac.c
> @@ -196,6 +196,7 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc)
>   	dma_async_tx_callback		callback;
>   	void				*param;
>   	struct dma_async_tx_descriptor	*txd =&desc->txd;
> +	struct dw_desc	*child;

    Shouldn't this varaible name be aligned with the above variable names?

WBR, Sergei
