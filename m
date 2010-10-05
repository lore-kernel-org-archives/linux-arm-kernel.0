From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 5 Oct 2010 12:06:49 +0200
Subject: [PATCH 4/4] dmaengine: Add Freescale i.MX1/21/27 DMA driver
In-Reply-To: <AANLkTikaAuBe=ef3vnt_xV0At4ZQbNsD4rFqtLF4R+0+@mail.gmail.com>
References: <1285854995-6569-1-git-send-email-s.hauer@pengutronix.de>
	<1285854995-6569-5-git-send-email-s.hauer@pengutronix.de>
	<AANLkTikaAuBe=ef3vnt_xV0At4ZQbNsD4rFqtLF4R+0+@mail.gmail.com>
Message-ID: <20101005100649.GL28242@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Tue, Oct 05, 2010 at 09:45:10AM +0200, javier Martin wrote:
> Hi Sascha,
> 
> 
> +
> > +struct imxdma_channel {
> > +       struct imxdma_engine            *imxdma;
> > +       unsigned int                    channel;
> > +       unsigned int                    imxdma_channel;
> > +
> > +       enum dma_data_direction         direction;
> > +       enum dma_slave_buswidth         word_size;
> > +       dma_addr_t                      bd_phys;
> > +       unsigned long                   flags;
> > +       dma_addr_t                      per_address;
> > +       u32                             watermark_level;
> > +       struct dma_chan                 chan;
> > +       spinlock_t                      lock;
> > +       struct dma_async_tx_descriptor  desc;
> > +       dma_cookie_t                    last_completed;
> > +       enum dma_status                 status;
> > +       int                             dma_request;
> > +       struct scatterlist              *sg_list;
> > +};
> > +
> > +#define MAX_DMA_CHANNELS 8
> >
> 
>  i.MX27 has 16 DMA channels. Maybe an #ifdef would solve the issue.

This is by intention. I want to reserve 8 channels for the old driver
and the remaining 8 for the dmaengine driver. This way we can have both
in the tree and use both drivers parallel. This can be changed to the
real value once the old driver is gone.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
