From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 24 Sep 2012 21:38:12 +0000 (UTC)
Subject: [PATCH] ARM: OMAP2+: Fix PMU interrupt definitions
In-Reply-To: <1348522362-912-1-git-send-email-jon-hunter@ti.com>
References: <1348522362-912-1-git-send-email-jon-hunter@ti.com>
Message-ID: <alpine.DEB.2.00.1209242137120.3221@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Sep 2012, Jon Hunter wrote:

> Commit 7d7e1eb (ARM: OMAP2+: Prepare for irqs.h removal) and commit ec2c082
> (ARM: OMAP2+: Remove hardcoded IRQs and enable SPARSE_IRQ) updated the way
> interrupts for OMAP2/3 devices are defined in the HWMOD data structures to
> being an index plus a fixed offset (defined by OMAP_INTC_START). The definition
> of the PMU interrupts on OMAP2/3 devices is missing the OMAP_INTC_START offset
> and so this is causing the allocation of PMU interrupts to fail on OMAP2/3
> devices. So add the offset to fix this.
> 
> This is patch is based upon the Tony's master branch for OMAP.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Thanks, looks like I missed that when the patch was rebased.  Queued into 
devel-late-fixes.


- Paul
