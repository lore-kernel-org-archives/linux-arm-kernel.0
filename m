From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 19 Oct 2016 18:45:20 +0530
Subject: [PATCH] dmaengine: st_fdma: fix uninitialized variable access
In-Reply-To: <20161019120927.3251235-1-arnd@arndb.de>
References: <20161019120927.3251235-1-arnd@arndb.de>
Message-ID: <20161019131519.GK2467@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 02:09:10PM +0200, Arnd Bergmann wrote:
> The newly added st_fdma driver introduces a build warning for
> allmodconfig when we add '-Wmaybe-uninitialized':
> 
> drivers/dma/st_fdma.c: In function 'st_fdma_probe':
> drivers/dma/st_fdma.c:777:5: error: 'ret' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> The warning is correct, though this can't happen in practice
> as the check is redundant (we don't get to this function if
> the pointer is NULL). Even if the function were called with a
> NULL of_node, the check is not needed because of_property_read_u32
> can deal with a NULL argument by returning an error.
> 
> Removing the unnecessary code simplifies the function and avoids
> the condition that we get the warning for.

Applied, thanks

-- 
~Vinod
