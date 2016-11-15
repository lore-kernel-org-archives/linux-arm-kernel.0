From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Nov 2016 11:31:34 +0100
Subject: [PATCH] ARM: dma-mapping: preallocate DMA-debug hash tables in
 pure_initcall
In-Reply-To: <1479204295-29773-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20161115100459eucas1p152b644d5d329192a0902c836b13f35ba@eucas1p1.samsung.com>
 <1479204295-29773-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <3289056.5bg7xtivbS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 15, 2016 11:04:55 AM CET Marek Szyprowski wrote:
> fs_initcall is definitely too late to initialize DMA-debug hash tables,
> because some drivers might get probed and use DMA mapping framework
> already in core_initcall. Late initialization of DMA-debug results in
> false warning about accessing memory, that was not allocated, like this
> one:

To ask the obvious question: what driver does DMA allocations in a
core_initcall, and have you tried to change that first?

	Arnd
