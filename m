From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 15 May 2017 14:25:22 -0300
Subject: [PATCH] soc: imx: Select PM_GENERIC_DOMAINS only if PM is enabled
In-Reply-To: <1494866011-23360-1-git-send-email-linux@roeck-us.net>
References: <1494866011-23360-1-git-send-email-linux@roeck-us.net>
Message-ID: <CAOMZO5DEXAYJxmjJ+gKyeOaOaxV=qJupiiOdB9ZdJxpRUYSoKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

On Mon, May 15, 2017 at 1:33 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> Selecting PM_GENERIC_DOMAINS without PM results in the following build
> errors, seen when building sparc32:allmodconfig.
>
> drivers/base/power/domain.c: In function 'genpd_queue_power_off_work':
> drivers/base/power/domain.c:279:13: error: 'pm_wq' undeclared
> drivers/base/power/domain.c: In function 'genpd_dev_pm_qos_notifier':
> drivers/base/power/domain.c:462:25: error:
>         'struct dev_pm_info' has no member named 'ignore_children'
> drivers/base/power/domain.c: In function 'rtpm_status_str':
> drivers/base/power/domain.c:2207:16: error:
>         'struct dev_pm_info' has no member named 'runtime_error'
> drivers/base/power/domain.c:2209:21: error:
>         'struct dev_pm_info' has no member named 'disable_depth'
> drivers/base/power/domain.c:2211:21: error:
>         'struct dev_pm_info' has no member named 'runtime_status'
> drivers/base/power/domain.c:2212:31: error:
>         'struct dev_pm_info' has no member named 'runtime_status'
>
> Fixes: 03aa12629fc4 ("soc: imx: Add GPCv2 power gating driver")
> Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

This patch from Arnd should fix it:
https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/commit/?h=imx/fixes&id=e23c7f7d57831fdae444be9d507e67716ab601d4

This one should land in linux-next tomorrow.
