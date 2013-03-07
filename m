From: rusty@rustcorp.com.au (Rusty Russell)
Date: Thu, 07 Mar 2013 16:51:23 +1100
Subject: [patch 2/7] tick: Convert broadcast cpu bitmaps to cpumask_var_t
In-Reply-To: <20130306111537.366394000@linutronix.de>
References: <20130306111351.883117670@linutronix.de>
 <20130306111537.366394000@linutronix.de>
Message-ID: <874ngnycys.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Gleixner <tglx@linutronix.de> writes:
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> ---
>  kernel/time/tick-broadcast.c |   86 +++++++++++++++++++++----------------------
>  kernel/time/tick-common.c    |    1 
>  kernel/time/tick-internal.h  |    3 +
>  3 files changed, 46 insertions(+), 44 deletions(-)
>
> Index: tip/kernel/time/tick-broadcast.c
> ===================================================================
> --- tip.orig/kernel/time/tick-broadcast.c
> +++ tip/kernel/time/tick-broadcast.c
> @@ -28,9 +28,8 @@
>   */
>  
>  static struct tick_device tick_broadcast_device;
> -/* FIXME: Use cpumask_var_t. */
> -static DECLARE_BITMAP(tick_broadcast_mask, NR_CPUS);
> -static DECLARE_BITMAP(tmpmask, NR_CPUS);
> +static cpumask_var_t tick_broadcast_mask;
> +static cpumask_var_t tmpmask;
>  static DEFINE_RAW_SPINLOCK(tick_broadcast_lock);
>  static int tick_broadcast_force;

Thanks, this is a nice cleanup.

Cheers,
Rusty.
