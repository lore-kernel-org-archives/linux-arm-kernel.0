From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Sep 2011 07:48:27 -0700
Subject: [PATCH v7 05/26] gpio/omap: handle save/restore context in
	GPIO driver
In-Reply-To: <1315918979-26173-6-git-send-email-tarun.kanti@ti.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<1315918979-26173-6-git-send-email-tarun.kanti@ti.com>
Message-ID: <20110921144826.GQ2937@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110913 05:29]:
> From: Charulatha V <charu@ti.com>
> 
> Modify omap_gpio_prepare_for_idle() & omap_gpio_resume_after_idle() functions
> to handle save context & restore context respectively in the OMAP GPIO driver
> itself instead of calling these functions from pm specific files.
> For this, in gpio_prepare_for_idle(), call *_get_context_loss_count() and in
> gpio_resume_after_idle() call it again. If the count is different, do restore
> context. The workaround_enabled flag is no more required and is removed.
> 
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

This to should be also acked by Kevin, looks OK to me:

Acked-by: Tony Lindgren <tony@atomide.com>
