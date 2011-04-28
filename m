From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Thu, 28 Apr 2011 23:38:07 +0900
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <201104281629.52863.arnd@arndb.de>
References: <201104281428.56780.arnd@arndb.de>
	<20110428131531.GK17290@n2100.arm.linux.org.uk>
	<201104281629.52863.arnd@arndb.de>
Message-ID: <20110428233538V.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm busy at a conference so I've not read the whole thread yet..

On Thu, 28 Apr 2011 16:29:52 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> I was mistaken there: all drivers that use dma_alloc_noncoherent
> either use dma_cache_sync() or they do something that is more broken,
> but they don't do dma_sync_*.

As the DMA-API.txt says, dma_alloc_noncoherent should be used with
dma_cache_sync(). You shouldn't use dma_sync* API with a memory
returned by dma_alloc_noncoherent().
