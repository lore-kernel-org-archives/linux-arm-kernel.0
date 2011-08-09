From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Tue, 9 Aug 2011 21:59:45 +0530
Subject: How to handle named resources with DT?
In-Reply-To: <4E40FC88.5090403@ti.com>
References: <4E40FC88.5090403@ti.com>
Message-ID: <20110809162907.GA630@manju-WNB7PBC4801-0006>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On Tue, Aug 09, 2011 at 11:23:20AM +0200, Cousson, Benoit wrote:
> Hi Grant,
> 
> Trying to bind hwmod informations with DT, I'm facing a little limitation.
> A bunch of drivers are using the platform_get_resource_byname, so
> the name for the resource is needed.
> 
> The name is used so far for IORESOURCE_MEM, IORESOURCE_IRQ and
> IORESOURCE_DMA types of resources.

IORESOURCE_MEM and IORESOURCE_IRQ's are fetched from dt blob and 
it will be part of pdev. For IORESOURCE_DMA, you can have property
"dma-channel" in dtsi file and fetch dma-channel in driver probe
through "of_property_read_u32()" api.

BTW, this is not required for omap since dt-hwmod binding will fetch
pdev pointer from hwmod database and it will be used "as is" without 
any modification which inturn does not break any existing pm 
functionality.

-M

> 
> Do you have any plan to add that, or do you have any clean way to
> avoid that without having to use the resource index?
> 
> Thanks,
> Benoit
