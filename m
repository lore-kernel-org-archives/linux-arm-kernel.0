From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 11 Apr 2012 14:13:21 +0530
Subject: [PATCH] ARM: OMAP2+: remove redundant sysconfig context restore
In-Reply-To: <1334133256-20475-1-git-send-email-tarun.kanti@ti.com>
References: <1334133256-20475-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <CAMQu2gw0feL22aVi-ZDffBzest0+sdMnL2Hwa6GwwVKiKF118Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC'ing LAKML

On Wed, Apr 11, 2012 at 2:04 PM, Tarun Kanti DebBarma
<tarun.kanti@ti.com> wrote:
> Since hwmod framework now manages sysconfig context save/restore
> there is no more need to touch this register in driver. Hence,
> remove restore of sysconfig register in omap_timer_restore_context.
> This was causing incorrect context restore of sysconfig register.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
> ?arch/arm/plat-omap/dmtimer.c | ? ?2 --
> ?1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 652139c..15e7882 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -82,8 +82,6 @@ static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
>
> ?static void omap_timer_restore_context(struct omap_dm_timer *timer)
> ?{
> - ? ? ? __raw_writel(timer->context.tiocp_cfg,
> - ? ? ? ? ? ? ? ? ? ? ? timer->io_base + OMAP_TIMER_OCP_CFG_OFFSET);
> ? ? ? ?if (timer->revision == 1)
> ? ? ? ? ? ? ? ?__raw_writel(timer->context.tistat, timer->sys_stat);
>

Looks good to me.

Acked-by: Santosh Shilimkar <santosh.shilimka@ti.com>
