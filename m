From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Jun 2011 17:24:20 +0200
Subject: [PATCH 2/8] ARM: dma-mapping: implement dma_map_single on top of
	dma_map_page
In-Reply-To: <000101cc2f5c$ec21da40$c4658ec0$%szyprowski@samsung.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<20110620143911.GD26089@n2100.arm.linux.org.uk>
	<000101cc2f5c$ec21da40$c4658ec0$%szyprowski@samsung.com>
Message-ID: <201106241724.21113.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 June 2011, Marek Szyprowski wrote:
> > This also breaks dmabounce when used with a highmem-enabled system -
> > dmabounce refuses the dma_map_page() API but allows the dma_map_single()
> > API.
> 
> I really not sure how this change will break dma bounce code. 
> 
> Does it mean that it is allowed to call dma_map_single() on kmapped HIGH_MEM 
> page?

dma_map_single on a kmapped page already doesn't work, the argument needs to
be inside of the linear mapping in order for virt_to_page to work.

	Arnd
