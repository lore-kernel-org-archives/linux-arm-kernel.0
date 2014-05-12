From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 12 May 2014 16:26:53 -0700
Subject: [PATCH 1/2] mtd/onenand: fix build warning for dma type
In-Reply-To: <1399560990-1402858-3-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-3-git-send-email-arnd@arndb.de>
Message-ID: <20140512232653.GV28907@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 04:56:14PM +0200, Arnd Bergmann wrote:
> The samsung onenand driver passes around a dma address token
> through a void pointer, which is incorrect and leads to
> warnings like this one:
> 
> onenand/samsung.c:548:2: warning: passing argument 1 of '__fswab32' makes integer from pointer without a cast [enabled by default]
>   writel(src, base + S5PC110_DMA_SRC_ADDR);
>   ^
> 
> This patch makes it use dma_addr_t here, which is more appropriate.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: linux-mtd at lists.infradead.org

Pushed this one to l2-mtd.git. Thanks!

I think the second MTD patch is still under discussion, right? I'll
follow up there if necessary.

Brian
