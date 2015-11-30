From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Nov 2015 15:09:33 +0100
Subject: [RFC v02 03/15] dmaengine: core: Introduce new,
 universal API to request a channel
In-Reply-To: <1448891145-10766-4-git-send-email-peter.ujfalusi@ti.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <1448891145-10766-4-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <2436417.uspUkNqtIA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 November 2015 15:45:33 Peter Ujfalusi wrote:
>                                                   const char *name);
>  struct dma_chan *dma_request_slave_channel(struct device *dev, const char *name);
> +
> +struct dma_chan *dma_request_chan(struct device *dev, const char *name);
> +struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
> +
>  void dma_release_channel(struct dma_chan *chan);
>  int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps);
>  #else
> @@ -1268,6 +1291,14 @@ static inline struct dma_chan *dma_request_slave_channel(struct device *dev,
>  {
>         return NULL;
>  }
> +static inline struct dma_chan *dma_request_chan(struct device *dev)
> +{
> +       return ERR_PTR(-ENODEV);
> +}
> 

The prototypes for dma_request_chan() don't match, otherwise looks good.

	Arnd
