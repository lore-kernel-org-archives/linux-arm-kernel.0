From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Jun 2017 10:43:28 +0200
Subject: [PATCH 25/44] arm: implement ->mapping_error
In-Reply-To: <20170608144313.GL4902@n2100.armlinux.org.uk>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-26-hch@lst.de>
 <20170608144313.GL4902@n2100.armlinux.org.uk>
Message-ID: <20170616084328.GC10582@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08, 2017 at 03:43:14PM +0100, Russell King - ARM Linux wrote:
> BOn Thu, Jun 08, 2017 at 03:25:50PM +0200, Christoph Hellwig wrote:
> > +static int dmabounce_mapping_error(struct device *dev, dma_addr_t dma_addr)
> > +{
> > +	if (dev->archdata.dmabounce)
> > +		return 0;
> 
> I'm not convinced that we need this check here:
> 
>         dev->archdata.dmabounce = device_info;
>         set_dma_ops(dev, &dmabounce_ops);
> 
> There shouldn't be any chance of dev->archdata.dmabounce being NULL if
> the dmabounce_ops has been set as the current device DMA ops.  So I
> think that test can be killed.

Ok, I'll fix it up.
