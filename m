From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 07 Mar 2012 13:01:41 +0100
Subject: [PATCH v3 09/13] gpio/omap: remove suspend/resume callbacks
In-Reply-To: <1331118963-26364-10-git-send-email-tarun.kanti@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
 <1331118963-26364-10-git-send-email-tarun.kanti@ti.com>
Message-ID: <4F574E25.6010702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 March 2012 12:15 PM, Tarun Kanti DebBarma wrote:
> Both omap_gpio_suspend() and omap_gpio_resume() does programming
> of wakeup_en register.
> _gpio_rmw(base, bank->regs->wkup_en, 0xffffffff, 0);
> _gpio_rmw(base, bank->regs->wkup_en, bank->context.wake_en, 1);
> 
> This is redundant in omap_gpio_suspend() because wakeup_en
> register automatically gets initialized in _set_gpio_wakeup()
> and set_gpio_trigger() while being called either from
> chip.irq_set_wake() or chip.irq_set_type().
> 
> This is redundant in omap_gpio_resume() because wakeup_en
s/This is/This is also

> register is programmed in omap_gpio_restore_context() called
> which is called from runtime resume callback.
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
