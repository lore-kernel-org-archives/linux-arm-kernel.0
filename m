From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Jun 2011 10:53:16 +0100
Subject: [PATCH] [RFC] USB: fsl_udc_core: fix build-failure for ARM
In-Reply-To: <20110621094834.GC23234@n2100.arm.linux.org.uk>
References: <20110505135029.0c068b8e@wker>
	<1304672405-1102-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110511063954.GJ29089@pengutronix.de>
	<20110511155446.GA20920@suse.de>
	<20110511162902.GG5315@n2100.arm.linux.org.uk>
	<20110522072009.GA9774@pengutronix.de>
	<BANLkTini+7kLMdCkU+kDWUXKfJ7DOPNVVA@mail.gmail.com>
	<20110621094834.GC23234@n2100.arm.linux.org.uk>
Message-ID: <20110621095316.GD23234@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 10:48:34AM +0100, Russell King - ARM Linux wrote:
> This is an iMX driver, which was written avoiding the DMA API despite
> it clearly doing DMA related stuff.  Allocating memory from kmalloc,
> translating it to physical addresses using virt_to_phys, etc.
> 
> The PPC people decided to reuse it, and ended up introducing some custom
> cache flushing APIs to get around the lack of dma_map_* usage.

Oops, no it wasn't - it was a freescale driver.  git log didn't go back
past the rename the imx people did.

But still, it needs converting to the DMA API rather than these private
arch bodges being introduced.
