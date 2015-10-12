From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 12 Oct 2015 21:30:25 +0530
Subject: [PATCH v4 11/25] ARM/dmaengine: edma: Merge the two drivers
 under drivers/dma/
In-Reply-To: <1443088932-21731-12-git-send-email-peter.ujfalusi@ti.com>
References: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
 <1443088932-21731-12-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20151012160024.GF27370@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2015 at 01:01:58PM +0300, Peter Ujfalusi wrote:
> Move the code out from arch/arm/common and merge it inside of the dmaengine
> driver.
> This change is done with as minimal change to the code as possible to avoid
> any possibilities to introducing regression.

Is this a pure move patch or code has been modified, if latter am
disappointed that existing code style issue have not been fixed


> +static inline void edma_write(struct edma_cc *ecc, int offset, int val)
> +{
> +	__raw_writel(val, ecc->base + offset);
> +}
> +static inline void edma_modify(struct edma_cc *ecc, int offset, unsigned and,
> +			       unsigned or)

This looks bad on my 80 char screen, and few more places below

> +{
> +	unsigned val = edma_read(ecc, offset);

checkpatch should have asked you to add empty line here, many places below
too

> +	val &= and;
> +	val |= or;
> +	edma_write(ecc, offset, val);
> +}

empty line here and few more places

More later :)

-- 
~Vinod
