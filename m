From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Mar 2012 11:36:35 -0800
Subject: [PATCH v2] ARM: OMAP: dmtimer: fix missing content/correction
 in low-power mode support
In-Reply-To: <1323237434-4919-1-git-send-email-tarun.kanti@ti.com>
References: <1323237434-4919-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <20120305193635.GM12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [111206 21:25]:
> Since omap_dm_timer_write_reg/__omap_dm_timer_write is now modified
> to use timer->func_base OCP_CFG should not use this wrapper anymore.
> Instead use __raw_writel() directly and use timer->io_base instead
> to write to OCP_CFG.
> 
> The timer->sys_stat is valid only if timer->revision is 1. In the
> context restore function make this correction.
> 
> Save the contexts and loss count when timer is stopped.
> Also, disable the clock. Else, clock usecount would become imbalanced.
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Tested-by: Omar Ramirez Luna <omar.ramirez@ti.com>

Thanks applying this to fixes-non-critical-part2. Sorry for the
delays, looks like I'm a bit behind with patches..

Regards,

Tony
