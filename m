From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jul 2012 19:27:04 +0000
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <500EF27F.6050905@ti.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <1342777047.1726.435.camel@vkoul-udesk3> <500EF27F.6050905@ti.com>
Message-ID: <201207241927.04542.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 July 2012, Jon Hunter wrote:
> Ok. The thought was that the user would have the following means of
> requesting a channel ...
> 
> 1. By name
> 2. By a filter parameter (flags)
> 3. By name and a filter parameter
> 
> So we would have the following APIs ...
> 
> struct dma_chan
> *of_dma_request_channel(struct device_node *node, unsigned int flags);
> struct dma_chan
> *of_dma_request_named channel(struct device_node *node, char *name,
> unsigned int flags);
> 
> In both of these the filter parameter flags is optional.
> 
> Let me know your thoughts on this.

I definitely like this version. I was thinking of a different variant
where we have separate functions for each flag value, but I think yours
is actually better.

	Arnd
