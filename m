From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Thu, 8 Dec 2011 02:36:31 +0200
Subject: [PATCH] ARM: OMAP: dmtimer: fix missing content/correction in
 low-power mode support
In-Reply-To: <1320732026-6783-1-git-send-email-tarun.kanti@ti.com>
References: <1320732026-6783-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <CAMP44s0LGVOWrKu8nTbDWdGJFoUH8kcg_nFQwnxFWHFQDf_5_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 8, 2011 at 8:00 AM, Tarun Kanti DebBarma <tarun.kanti@ti.com> wrote:
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

It looks like this patch is doing 3 things, so I think this patch
should be split into 3 logical patches.

-- 
Felipe Contreras
