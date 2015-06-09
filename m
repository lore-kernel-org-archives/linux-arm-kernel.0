From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 09 Jun 2015 11:17:29 +0200
Subject: [PATCH 2/2] cpufreq: mediatek: Add MT8173 cpufreq driver
In-Reply-To: <1433766561-1330-3-git-send-email-pi-cheng.chen@linaro.org>
References: <1433766561-1330-1-git-send-email-pi-cheng.chen@linaro.org>
 <1433766561-1330-3-git-send-email-pi-cheng.chen@linaro.org>
Message-ID: <1433841449.16887.58.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-06-08 at 20:29 +0800, Pi-Cheng Chen wrote:
> --- /dev/null
> +++ b/drivers/cpufreq/mt8173-cpufreq.c

> +#include <linux/module.h>

Weren't you going to drop this include?

> +module_init(mt8173_cpufreq_driver_init);

For built-in code this is equivalent to, speaking from memory:
    device_initcall(mt8173_cpufreq_driver_init);

Why don't you just use that directly?

Thanks,


Paul Bolle
