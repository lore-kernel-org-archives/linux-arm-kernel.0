From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 15 Sep 2012 01:14:31 +0100
Subject: [PATCH V6 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <1347662517-4210-2-git-send-email-jon-hunter@ti.com>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com>
 <1347662517-4210-2-git-send-email-jon-hunter@ti.com>
Message-ID: <20120915001431.GB12445@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 05:41:56PM -0500, Jon Hunter wrote:
> 3. Supporting legacy devices not using DMA Engine
> 
>    These devices present a problem, as there may not be a uniform way to easily
>    support them with regard to device tree. Ideally, these should be migrated
>    to DMA engine. However, if this is not possible, then they should still be
>    able to use this binding, the only constaint imposed by this implementation
>    is that when requesting a DMA channel via of_dma_request_slave_channel(), it
>    will return a type of dma_chan.

As far as devices not using DMA engine, the answer is we don't support
their specification in the DT model.  Note that the legacy OMAP DMA
API is scheduled for removal next year, so it's not going to be around
that much longer.
