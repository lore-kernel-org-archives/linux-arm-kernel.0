From: javier.martin@vista-silicon.com (javier Martin)
Date: Tue, 5 Oct 2010 09:45:10 +0200
Subject: [PATCH 4/4] dmaengine: Add Freescale i.MX1/21/27 DMA driver
In-Reply-To: <1285854995-6569-5-git-send-email-s.hauer@pengutronix.de>
References: <1285854995-6569-1-git-send-email-s.hauer@pengutronix.de>
	<1285854995-6569-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <AANLkTikaAuBe=ef3vnt_xV0At4ZQbNsD4rFqtLF4R+0+@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,


+
> +struct imxdma_channel {
> +       struct imxdma_engine            *imxdma;
> +       unsigned int                    channel;
> +       unsigned int                    imxdma_channel;
> +
> +       enum dma_data_direction         direction;
> +       enum dma_slave_buswidth         word_size;
> +       dma_addr_t                      bd_phys;
> +       unsigned long                   flags;
> +       dma_addr_t                      per_address;
> +       u32                             watermark_level;
> +       struct dma_chan                 chan;
> +       spinlock_t                      lock;
> +       struct dma_async_tx_descriptor  desc;
> +       dma_cookie_t                    last_completed;
> +       enum dma_status                 status;
> +       int                             dma_request;
> +       struct scatterlist              *sg_list;
> +};
> +
> +#define MAX_DMA_CHANNELS 8
>

 i.MX27 has 16 DMA channels. Maybe an #ifdef would solve the issue.


-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101005/646920ac/attachment-0001.html>
