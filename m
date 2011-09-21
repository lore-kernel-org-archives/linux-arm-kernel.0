From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Sep 2011 07:47:20 -0700
Subject: [PATCH v7 04/26] gpio/omap: fix pwrdm_post_transition call
	sequence
In-Reply-To: <1315918979-26173-5-git-send-email-tarun.kanti@ti.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<1315918979-26173-5-git-send-email-tarun.kanti@ti.com>
Message-ID: <20110921144720.GP2937@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110913 05:29]:
> From: Charulatha V <charu@ti.com>
> 
> The context lost count is modified in omap_sram_idle() path when
> pwrdm_post_transition() is called. But pwrdm_post_transition() is called
> only after omap_gpio_resume_after_idle() is called. Correct this so that
> context lost count is modified before calling omap_gpio_resume_after_idle().
> 
> This would be useful when OMAP GPIO save/restore context is called by
> the OMAP GPIO driver itself.
> 
> Signed-off-by: Charulatha V <charu@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

This should be acked by Kevin, looks OK to me:

Acked-by: Tony Lindgren <tony@atomide.com>
