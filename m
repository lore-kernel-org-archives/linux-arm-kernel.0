From: arnd.bergmann@linaro.org (Arnd Bergmann)
Date: Mon, 23 Jul 2012 08:46:41 +0000
Subject: [PATCH][RFC] arm: dma-mapping: Add support for allocating/mapping
 cached buffers
In-Reply-To: <038d01cd68a3$e23d7990$a6b86cb0$%szyprowski@samsung.com>
References: <1342202506-12449-1-git-send-email-lauraa@codeaurora.org>
 <5009BFE0.5050501@codeaurora.org>
 <038d01cd68a3$e23d7990$a6b86cb0$%szyprowski@samsung.com>
Message-ID: <201207230846.41869.arnd.bergmann@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 July 2012, Marek Szyprowski wrote:
> I would like to completely remove dma_cache_sync() and replace it with 
> dma_sync_single_for_cpu/device(), but this probably require a bit more
> discussion and fixing all current clients of dma_cache_sync().

Sounds like a good idea. Fortunately, there are only a handful of such
drivers in the kernel, and even fewer machines that actually need this,
so we should be able to find all the people that care about these.

	Arnd
