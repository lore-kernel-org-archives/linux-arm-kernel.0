From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 23 Apr 2013 09:14:07 +0530
Subject: [PATCH v3 1/6] at_hdmac: move to generic DMA binding
In-Reply-To: <51750F68.4040701@atmel.com>
References: <1366362683-14496-1-git-send-email-ludovic.desroches@atmel.com>
 <1366362683-14496-2-git-send-email-ludovic.desroches@atmel.com>
 <51750F68.4040701@atmel.com>
Message-ID: <20130423034407.GY24632@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 12:22:32PM +0200, Nicolas Ferre wrote:
> On 04/19/2013 11:11 AM, ludovic.desroches at atmel.com :
> > From: Ludovic Desroches <ludovic.desroches@atmel.com>

> > +#ifdef CONFIG_OF
> > +static bool at_dma_filter(struct dma_chan *chan, void *slave)
this is not defined for else case here. Also this could be CONFIG_DMA_OF...?
> > +{
> > +	struct at_dma_slave *atslave = slave;
> > +
> > +	if (atslave->dma_dev == chan->device->dev) {
> > +		chan->private = atslave;
> > +		return true;
> > +	} else {
> > +		return false;
> > +	}
> > +}

--
~Vinod
