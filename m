From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 11 Feb 2013 09:57:36 +0530
Subject: [PATCH 1/2] drivers/cpufreq: delete dangling include
In-Reply-To: <1360513959-31695-1-git-send-email-linus.walleij@stericsson.com>
References: <1360513959-31695-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAOh2x=mM7TyTfg-O==vhiTGNOc2EAwUXtp-Sxa95Y9ZSc6U8=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 10, 2013 at 10:02 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>
> There was a dangling #include <mach/id.h> in the cpufreq
> file missing from commit
> 7a4f26097d389c16c9956bc03b81532698d97d64
> "ARM: ux500: de-globalize <mach/id.h>"
>
> Causing build regressions when building with cpufreq
> support.

Linus,

Both subject and log are missing db8500 :(

> Cc: arm at kernel.org
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC: please merge this patch directly to the
> next/cleanup branch once Rafael ACK it or you think it's
> taken too long (the patch is pretty obvious).
> ---
>  drivers/cpufreq/db8500-cpufreq.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/cpufreq/db8500-cpufreq.c b/drivers/cpufreq/db8500-cpufreq.c
> index 523c940..87130e2 100644
> --- a/drivers/cpufreq/db8500-cpufreq.c
> +++ b/drivers/cpufreq/db8500-cpufreq.c
> @@ -15,7 +15,6 @@
>  #include <linux/slab.h>
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
> -#include <mach/id.h>
>
>  static struct cpufreq_frequency_table *freq_table;
>  static struct clk *armss_clk;

Otherwise,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
