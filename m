From: tj@kernel.org (Tejun Heo)
Date: Tue, 19 Aug 2014 11:14:17 -0400
Subject: [PATCH v7 2/3] ahci_xgene: Skip the PHY and clock initialization
 if already configured by the firmware.
In-Reply-To: <1408429911-1406-3-git-send-email-stripathi@apm.com>
References: <1408429911-1406-1-git-send-email-stripathi@apm.com>
 <1408429911-1406-3-git-send-email-stripathi@apm.com>
Message-ID: <20140819151417.GA16480@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 12:01:50PM +0530, Suman Tripathi wrote:
> This patch implements the feature to skip the PHY and clock
> initialization if it is already configured by the firmware.
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
...
> +static int xgene_ahci_is_memram_inited(struct xgene_ahci_context *ctx)
> +{
> +	void __iomem *diagcsr = ctx->csr_diag;
> +
> +	if (readl(diagcsr + CFG_MEM_RAM_SHUTDOWN) == 0 &&
> +	    readl(diagcsr + BLOCK_MEM_RDY) == 0xFFFFFFFF)
> +		return 1;
> +	return 0;
> +}

Please make it return bool.

Thanks.

-- 
tejun
