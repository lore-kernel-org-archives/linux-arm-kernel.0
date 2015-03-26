From: tony@atomide.com (Tony Lindgren)
Date: Thu, 26 Mar 2015 08:22:04 -0700
Subject: [PATCH v2 3/7] dmaengine: Add driver for TI DMA crossbar on DRA7x
In-Reply-To: <5513FC22.2030304@ti.com>
References: <1426080210-841-1-git-send-email-peter.ujfalusi@ti.com>
 <1426080210-841-4-git-send-email-peter.ujfalusi@ti.com>
 <20150326105603.GK32683@intel.com> <5513FC22.2030304@ti.com>
Message-ID: <20150326152204.GF31346@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [150326 05:32]:
> On 03/26/2015 12:56 PM, Vinod Koul wrote:
> >> +
> >> +static void ti_dma_xbar_free(struct device *dev, void *route_data)
> >> +{
> >> +	struct ti_dma_xbar_data *xbar = dev_get_drvdata(dev);
> >> +	struct ti_dma_xbar_map *map = route_data;
> >> +
> >> +	dev_dbg(dev, "Unmapping XBAR%d (was routed to %d)\n",
> >> +		map->xbar_in, map->xbar_out);
> >> +
> >> +	regmap_write(xbar->regmap, map->xbar_out * 2, 0);
> > just out of curiosity how much do you save using regmap :)
> 
> good point, not much I guess. I had it implemented w/o regmap as well, but
> thought why not use regmap if it is available.

Regmap is nice for slow devices and devices in a shared register
range like the omap syscon general area. For normal use, there's
quite a bit of overhead with regmap compared to just read/write :)

Regards,

Tony
