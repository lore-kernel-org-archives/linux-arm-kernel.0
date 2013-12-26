From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 26 Dec 2013 04:20:15 +0000 (UTC)
Subject: [PATCH] ARM: OMAP2+: hwmod_data: fix missing OMAP_INTC_START in
 irq data
In-Reply-To: <1387839191-57886-1-git-send-email-s-anna@ti.com>
References: <1387839191-57886-1-git-send-email-s-anna@ti.com>
Message-ID: <alpine.DEB.2.02.1312260417180.15949@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Dec 2013, Suman Anna wrote:

> Commit 7d7e1eb (ARM: OMAP2+: Prepare for irqs.h removal) and commit
> ec2c082 (ARM: OMAP2+: Remove hardcoded IRQs and enable SPARSE_IRQ)
> updated the way interrupts for OMAP2/3 devices are defined in the
> HWMOD data structures to being an index plus a fixed offset (defined
> by OMAP_INTC_START).
> 
> Couple of irqs in the OMAP2/3 hwmod data were misconfigured completely
> as they were missing this OMAP_INTC_START relative offset. Add this
> offset back to fix the incorrect irq data for the following modules:
> 	OMAP2 - GPMC, RNG
> 	OMAP3 - GPMC, ISP MMU & IVA MMU
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> This patch is applicable to only current 3.13 and past kernels (from
> 3.7 onwards), it is not needed for 3.14 as this IRQ data has already
> been cleaned up in Tony's omap-for-v3.14/omap3-board-removal branch.

Please don't forget to Cc the linux-arm-kernel mailing list.  I've done it 
for you this time.

Also, for fixes patches, please start adding "Fixes:" lines, and Cc: lines 
for the original patch authors.  For example, I've added these to the 
patch:

    Fixes: 7d7e1eba7e92 ("ARM: OMAP2+: Prepare for irqs.h removal")
    Fixes: ec2c0825ca31 ("ARM: OMAP2+: Remove hardcoded IRQs and enable SPARSE_IRQ")
    Cc: Tony Lindgren <tony@atomide.com>

But it would be much better if you could do this.

Queued.


- Paul
