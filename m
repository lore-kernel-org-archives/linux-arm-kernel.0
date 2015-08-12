From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 12 Aug 2015 13:13:15 -0700
Subject: [PATCH 4/9] kernel/cpu_pm: fix cpu_cluster_pm_exit comment
In-Reply-To: <1438731339-58317-5-git-send-email-lina.iyer@linaro.org> (Lina
 Iyer's message of "Tue, 4 Aug 2015 17:35:34 -0600")
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438731339-58317-5-git-send-email-lina.iyer@linaro.org>
Message-ID: <7htws4mfj8.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lina Iyer <lina.iyer@linaro.org> writes:

> cpu_cluster_pm_exit() must be sent after cpu_cluster_pm_enter() has been
> sent for the cluster and before any cpu_pm_exit() notifications are sent
> for any CPU.
>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

Acked-by: Kevin Hilman <khilman@linaro.org>

> ---
>  kernel/cpu_pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
> index 9656a3c..009cc9a 100644
> --- a/kernel/cpu_pm.c
> +++ b/kernel/cpu_pm.c
> @@ -180,7 +180,7 @@ EXPORT_SYMBOL_GPL(cpu_cluster_pm_enter);
>   * low power state that may have caused some blocks in the same power domain
>   * to reset.
>   *
> - * Must be called after cpu_pm_exit has been called on all cpus in the power
> + * Must be called after cpu_cluster_pm_enter has been called for the power
>   * domain, and before cpu_pm_exit has been called on any cpu in the power
>   * domain. Notified drivers can include VFP co-processor, interrupt controller
>   * and its PM extensions, local CPU timers context save/restore which
