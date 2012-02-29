From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 29 Feb 2012 17:53:35 +0800
Subject: [Linaro-mm-sig] [PATCHv23 13/16] drivers: add Contiguous Memory
 Allocator
In-Reply-To: <1329929337-16648-14-git-send-email-m.szyprowski@samsung.com>
References: <1329929337-16648-1-git-send-email-m.szyprowski@samsung.com>
 <1329929337-16648-14-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CAGsJ_4ygM6YAUj5mcskuEYcaJqYVHp_qzbUJvE9_huFhFcWtkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/2/23 Marek Szyprowski <m.szyprowski@samsung.com>:
> The Contiguous Memory Allocator is a set of helper functions for DMA
> mapping framework that improves allocations of contiguous memory chunks.
>
> CMA grabs memory on system boot, marks it with MIGRATE_CMA migrate type
> and gives back to the system. Kernel is allowed to allocate only movable
> pages within CMA's managed memory so that it can be used for example for
> page cache when DMA mapping do not use it. On
> dma_alloc_from_contiguous() request such pages are migrated out of CMA
> area to free required contiguous block and fulfill the request. This
> allows to allocate large contiguous chunks of memory at any time
> assuming that there is enough free memory available in the system.
>
> This code is heavily based on earlier works by Michal Nazarewicz.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Tested-by: Rob Clark <rob.clark@linaro.org>
> Tested-by: Ohad Ben-Cohen <ohad@wizery.com>
> Tested-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Tested-by: Robert Nelson <robertcnelson@gmail.com>

if there is a /proc/cmainfo like /proc/slabinfo, it might be helpful
to people as we can see the usage of CMA clearly.

Thanks
barry
