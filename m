From: rafael@kernel.org (Rafael J. Wysocki)
Date: Wed, 10 Feb 2016 16:28:33 +0100
Subject: [PATCH] cpufreq: select IRQ_WORK in Kconfig
In-Reply-To: <1455117265-3007562-1-git-send-email-arnd@arndb.de>
References: <1455117265-3007562-1-git-send-email-arnd@arndb.de>
Message-ID: <CAJZ5v0jqyd41Vzm61BEMeSHs=sAGYghM77nipBMVhQiyRfeqGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 4:14 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The cpufreq core code has started using the irq_work infrastructure, but that
> can be disabled in Kconfig, causing a link failure:
>
> drivers/cpufreq/cpufreq_governor.c: In function 'gov_queue_irq_work':
> drivers/cpufreq/cpufreq_governor.c:251:3: error: implicit declaration of function 'irq_work_queue_on' [-Werror=implicit-function-declaration]
>
> This adds an explicit 'select' to ensure it's always enabled.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 0144fa03ef46 ("cpufreq: governor: Replace timers with utilization update callbacks")
> ---
>  drivers/cpufreq/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 3050e8d48887..ca05037dd565 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -3,6 +3,7 @@ menu "CPU Frequency scaling"
>  config CPU_FREQ
>         bool "CPU Frequency scaling"
>         select SRCU
> +       select IRQ_WORK
>         help
>           CPU Frequency scaling allows you to change the clock speed of
>           CPUs on the fly. This is a nice method to save power, because
> --

Good catch, thanks!

I'll update the patch to do that.

Thanks,
Rafael
