From: santosh.shilimkar@ti.com (Santosh)
Date: Tue, 23 Aug 2011 18:17:48 +0530
Subject: [PATCH v5 04/22] gpio/omap: fix pwrdm_post_transition call
	sequence
In-Reply-To: <1312455893-14922-5-git-send-email-tarun.kanti@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
	<1312455893-14922-5-git-send-email-tarun.kanti@ti.com>
Message-ID: <4E53A174.4060408@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> From: Charulatha V<charu@ti.com>
>
> The context lost count is modified in omap_sram_idle() path when
> pwrdm_post_transition() is called. But pwrdm_post_transition() is called
> only after omap_gpio_resume_after_idle() is called. Correct this so that
> context lost count is modified before calling omap_gpio_resume_after_idle().
>
> This would be useful when OMAP GPIO save/restore context is called by
> the OMAP GPIO driver itself.
>
> Signed-off-by: Charulatha V<charu@ti.com>
> ---
Looks good to me.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

regards
Santosh
