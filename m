From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Jul 2013 10:30:55 +0100
Subject: [PATCH] dmaengine: Add MOXA ART DMA engine driver
In-Reply-To: <1373446263-7772-1-git-send-email-jonas.jensen@gmail.com>
References: <1373446263-7772-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <20130710093055.GW24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 10, 2013 at 10:51:03AM +0200, Jonas Jensen wrote:
> +#include "virt-dma.h"
...
> +struct moxart_dma_chan {
> +	struct virt_dma_chan		vchan;
...
> +static inline struct moxart_dma_chan *to_moxart_dma_chan(struct dma_chan *c)
> +{
> +	return container_of(c, struct moxart_dma_chan, vchan.chan);
> +}
...
> +	for (i = 0; i < APB_DMA_MAX_CHANNEL; i++, mchan++) {
> +		mchan->ch_num = i;
> +		mchan->reg = (struct moxart_dma_reg *)(dma_base_addr + 0x80
> +			     + i * sizeof(struct moxart_dma_reg));
> +		mchan->callback = NULL;
> +		mchan->allocated = 0;
> +		mchan->callback_param = NULL;
> +		vchan_init(&mchan->vchan, &mdc->dma_slave);

Do you actually make any use what so ever of the vchan support?
