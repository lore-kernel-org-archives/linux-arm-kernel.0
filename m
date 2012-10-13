From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 13 Oct 2012 18:19:06 +0530
Subject: [PATCH] ARM: OMAP4: Fix twd_local_timer_register regression
In-Reply-To: <20121012165149.GE30339@atomide.com>
References: <20121012165149.GE30339@atomide.com>
Message-ID: <50796342.2060907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 October 2012 10:21 PM, Tony Lindgren wrote:
> Commit 7d7e1eba (ARM: OMAP2+: Prepare for irqs.h removal)
> changed the interrupts to allow enabling sparse IRQ, but
> accidentally added the omap3 INTC base to the local IRQ.
> This causes the following:
>
> twd: can't register interrupt 45 (-22)
> twd_local_timer_register failed -22
>
> The right fix is to not add any base, as it is a local
> timer. For the OMAP44XX_IRQ_LOCALWDT we had defined earlier
> there are no users, so no need to fix that.
>
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
