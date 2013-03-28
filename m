From: horms@verge.net.au (Simon Horman)
Date: Thu, 28 Mar 2013 09:55:11 +0900
Subject: [PATCH v4 2/2] ARM: shmobile: r8a7740: Migrate from INTC to GIC
In-Reply-To: <1364392444-25181-2-git-send-email-hechtb+renesas@gmail.com>
References: <1364392444-25181-1-git-send-email-hechtb+renesas@gmail.com>
 <1364392444-25181-2-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <20130328005511.GH20736@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 02:54:04PM +0100, Bastian Hecht wrote:
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
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, queued up for v3.10 in the soc branch.
