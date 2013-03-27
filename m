From: horms@verge.net.au (Simon Horman)
Date: Wed, 27 Mar 2013 14:04:37 +0900
Subject: [PATCH v3 2/2] ARM: shmobile: r8a7740: Migrate from INTC to GIC
In-Reply-To: <1364296699-20919-2-git-send-email-hechtb+renesas@gmail.com>
References: <1364296699-20919-1-git-send-email-hechtb+renesas@gmail.com>
 <1364296699-20919-2-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <20130327050437.GI25431@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 26, 2013 at 12:18:19PM +0100, Bastian Hecht wrote:
> With the added capabilty of the intc_irqpin driver to handle shared
> external IRQs, all prerequisites are fulfilled and we are ready to
> migrate completely to GIC. This includes the following steps:
> 
> - Kconfig:	select ARM_GIC and RENESAS_INTC_IRQPIN
> - intc-r8a7740: Throw out all legacy INTC code and init the GIC. We need
>   		to mask out all shared IRQs as it is needed by the
> 		shared intc_irqpin driver.
> - setup-r8a7740: Add 4 irqpin devices to handle external IRQs and update
> 		all IRQ numbers to point to the GIC SPI.
> - board-armadillo: Update all IRQ numbers to point to the GIC SPI.
> - pfc-r8a7740:	Update all IRQ numbers of the GPIOs to point to the GIC
> 		SPI.
> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> ---
> v3:
> 
> In intc-r8a7740.c: Using ioremap instead of relying on a 1:1 mapping provided
> by setup-r8a7740.c. Corrected register width mismatch (intc_prio is 32 bits
> not 8).
> 
> In setup-r8a7740.c: Swapped two gic_spi entries of DMA3.

Hi Bastian,

I am having a little trouble applying this patch.

Could you please either let me know which commit id in the renesas
tree this is based on; or rebase it on the next branch in the renesas tree.

Thanks.
