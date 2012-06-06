From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jun 2012 10:29:46 +0100
Subject: [PATCH] ARM: mm: fix type of the arm_dma_limit global variable
In-Reply-To: <1338974843-5079-1-git-send-email-m.szyprowski@samsung.com>
References: <20120605220744.GB29782@n2100.arm.linux.org.uk>
 <1338974843-5079-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20120606092946.GL8262@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 06, 2012 at 11:27:23AM +0200, Marek Szyprowski wrote:
> arm_dma_limit stores physical address of maximal address accessible by DMA,
> so the phys_addr_t type makes much more sence for it instead of u32. This
> patch fixes the following build warning:
> 
> arch/arm/mm/init.c:380: warning: comparison of distinct pointer types lacks a cast

I assume this is not compile tested with CONFIG_ZONE_DMA=y, because:

arch/arm/mm/mm.h:extern u32 arm_dma_limit;

would also need to be fixed.
