From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 4 May 2015 11:08:51 +0530
Subject: [PATCH v5 3/8] dmaengine: Add driver for TI DMA crossbar on DRA7x
In-Reply-To: <1428572154-3548-4-git-send-email-peter.ujfalusi@ti.com>
References: <1428572154-3548-1-git-send-email-peter.ujfalusi@ti.com>
 <1428572154-3548-4-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20150504053851.GY3521@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 09, 2015 at 12:35:49PM +0300, Peter Ujfalusi wrote:
> +int omap_dmaxbar_init(void)
> +{
> +	return platform_driver_register(&ti_dma_xbar_driver);
> +}
> +arch_initcall(omap_dmaxbar_init);
All looks fine except this bit, I think I did point out this last time as
well, though dont recall your answer. We rather depend on defered probe and
not rely on module ordering.

-- 
~Vinod
