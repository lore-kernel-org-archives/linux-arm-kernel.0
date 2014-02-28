From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Feb 2014 10:23:06 +0100
Subject: [PATCH] dma: of: Move the functions under CONFIG_OF_DMA instead
 of CONFIG_OF
In-Reply-To: <530FD7D7.9000104@ti.com>
References: <1393546850-13907-1-git-send-email-santosh.shilimkar@ti.com>
 <530FD7D7.9000104@ti.com>
Message-ID: <6287295.Q1WPJPjeZV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 February 2014 19:27:03 Santosh Shilimkar wrote:
> 
> The of-dma.c is compiled out with !CONFIG_DMA_OF but the functions in
> the header are kept under CONFIG_OF. Move them under CONFIG_OF_DMA
> to avoid build errors with CONFIG_OFF && !CONFIG_DMA_OF
> 
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Sorry, but what is the problem you are seeing with this?

CONFIG_DMA_OF is defined as 'OF && DMAENGINE', and this code
should only be called from drivers that depend on DMAENGINE.

I'm not saying your patch is wrong, but you shouldn't need it
unless you do something very odd.

	Arnd
