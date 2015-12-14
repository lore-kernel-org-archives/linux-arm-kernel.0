From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 14 Dec 2015 22:39:38 +0200
Subject: [PATCH V02 3/5] dmaengine: core: Introduce new, universal API to
 request a channel
In-Reply-To: <1450092140-31602-4-git-send-email-peter.ujfalusi@ti.com>
References: <1450092140-31602-1-git-send-email-peter.ujfalusi@ti.com>
 <1450092140-31602-4-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <566F290A.2060300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/14/2015 01:22 PM, Peter Ujfalusi wrote:

>  /**
> + * struct dma_slave_map - associates slave device and it's slave channel with
> + * parameter to be used by a filter function
> + * @devname: name of the device
> + * @slave: slave channel name
> + * @param: opaque parameter to pass to struct dma_filter.fn
> + */
> +struct dma_slave_map {
> +        const char *devname;
> +        const char *slave;
> +        void *param;

??? Tabs got replaced by spaces ???

> +};
> +
> +/**
> + * struct dma_filter - information for slave device/channel to filter_fn/param
> + * mapping
> + * @fn: filter function callback
> + * @mapcnt: number of slave device/channel in the map
> + * @map: array of channel to filter mapping data
> + */
> +struct dma_filter {
> +        dma_filter_fn fn;
> +        int mapcnt;
> +        const struct dma_slave_map *map;

Here also.

-- 
P?ter
