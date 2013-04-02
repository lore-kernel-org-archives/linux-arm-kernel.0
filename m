From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 02 Apr 2013 16:26:36 -0700
Subject: [PATCH 1/3] clk: ux500: Add support for sysctrl clocks
In-Reply-To: <1364943987-1338-2-git-send-email-ulf.hansson@stericsson.com>
References: <1364943987-1338-1-git-send-email-ulf.hansson@stericsson.com>
 <1364943987-1338-2-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20130402232636.8177.41113@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ulf Hansson (2013-04-02 16:06:25)
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> The abx500 sysctrl clocks are using the ab8500 sysctrl driver to
> modify the clock hardware. Sysctrl clocks are represented by a
> ab8500 sysctrl register and with a corresponding bitmask.
> 
> The sysctrl clocks are slow path clocks, which means clk_prepare
> and clk_unprepare will be used to gate|ungate these clocks.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/clk/ux500/Makefile      |    1 +
>  drivers/clk/ux500/clk-sysctrl.c |  224 +++++++++++++++++++++++++++++++++++++++
>  drivers/clk/ux500/clk.h         |   29 +++++
>  3 files changed, 254 insertions(+)
>  create mode 100644 drivers/clk/ux500/clk-sysctrl.c
> 
> diff --git a/drivers/clk/ux500/Makefile b/drivers/clk/ux500/Makefile
> index bcc0c11..c6a806e 100644
> --- a/drivers/clk/ux500/Makefile
> +++ b/drivers/clk/ux500/Makefile
> @@ -5,6 +5,7 @@
>  # Clock types
>  obj-y += clk-prcc.o
>  obj-y += clk-prcmu.o
> +obj-y += clk-sysctrl.o
>  
>  # Clock definitions
>  obj-y += u8500_clk.o
> diff --git a/drivers/clk/ux500/clk-sysctrl.c b/drivers/clk/ux500/clk-sysctrl.c
> new file mode 100644
> index 0000000..72c826d
> --- /dev/null
> +++ b/drivers/clk/ux500/clk-sysctrl.c
> @@ -0,0 +1,224 @@
> +/*
> + * Sysctrl clock implementation for ux500 platform.
> + *
> + * Copyright (C) 2013 ST-Ericsson SA
> + * Author: Ulf Hansson <ulf.hansson@linaro.org>
> + *
> + * License terms: GNU General Public License (GPL) version 2
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clk-private.h>

I think the above header accidentally slipped in.

Regards,
Mike
