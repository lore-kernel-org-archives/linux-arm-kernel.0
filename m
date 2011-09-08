From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Sep 2011 16:52:20 +0200
Subject: [PATCH] dmaengine: add CSR SiRFprimaII DMAC driver
In-Reply-To: <1315374075-15479-1-git-send-email-Baohua.Song@csr.com>
References: <1315374075-15479-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <201109081652.20552.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 September 2011, Barry Song wrote:
> +/*
> + * The DMA controller consists of 16 independent DMA channels.
> + * Each channel is allocated to a different function
> + */
> +bool sirfsoc_dma_filter_id(struct dma_chan *chan, void *chan_id)
> +{
> +       unsigned int ch_nr = (unsigned int) chan_id;
> +
> +       if (ch_nr == chan->chan_id)
> +               return true;
> +
> +       return false;
> +}
> +EXPORT_SYMBOL(sirfsoc_dma_filter_id);
> +

Hi Barry,

It seems wrong that you have to export this function. The dmaengine API
should be able to work without this, and when you have drivers using the
interface, those should not rely on a specific implementation as the
purpose of the API is specifically to hide that.

Am I missing something?

	Arnd
