From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 1 Jul 2016 08:40:31 +0530
Subject: [PATCH] dmaengine: bcm2835: fix 64-bit warning
In-Reply-To: <20160630124845.184259-1-arnd@arndb.de>
References: <20160630124845.184259-1-arnd@arndb.de>
Message-ID: <20160701031031.GR14945@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2016 at 02:47:10PM +0200, Arnd Bergmann wrote:
> When building this driver on arm64, we get a harmless type
> mismatch warning:
> 
> drivers/dma/bcm2835-dma.c: In function 'bcm2835_dma_fill_cb_chain_with_sg':
> include/linux/kernel.h:743:17: warning: comparison of distinct pointer types lacks a cast
>   (void) (&_min1 == &_min2);  \
>                  ^
> drivers/dma/bcm2835-dma.c:409:21: note: in expansion of macro 'min'
>     cb->cb->length = min(len, max_len);
> 
> This changes the type of the 'len' variable to size_t, which
> avoids the problem.

Applied, thanks

-- 
~Vinod
