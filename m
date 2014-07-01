From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 01 Jul 2014 10:30:22 -0700
Subject: [PATCH v5 03/14] clk: max77686: Add DT include for MAX77686 PMIC
 clock
In-Reply-To: <1403806546-31122-4-git-send-email-javier.martinez@collabora.co.uk>
References: <1403806546-31122-1-git-send-email-javier.martinez@collabora.co.uk>
 <1403806546-31122-4-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20140701173022.32686.28561@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Javier Martinez Canillas (2014-06-26 11:15:35)
> This patch adds a dt-binding include for Maxim 77686
> PMIC clock IDs that can be to be shared between the
> clk-max77686 clock driver and DeviceTree source files.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Looks good to me.

Regards,
Mike

> ---
> 
> Changes since v4: None
> 
> Changes since v3: None
> 
>  drivers/clk/clk-max77686.c                 |  7 +------
>  include/dt-bindings/clock/maxim,max77686.h | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+), 6 deletions(-)
>  create mode 100644 include/dt-bindings/clock/maxim,max77686.h
> 
> diff --git a/drivers/clk/clk-max77686.c b/drivers/clk/clk-max77686.c
> index 3d7e8dd..185b611 100644
> --- a/drivers/clk/clk-max77686.c
> +++ b/drivers/clk/clk-max77686.c
> @@ -30,12 +30,7 @@
>  #include <linux/mutex.h>
>  #include <linux/clkdev.h>
>  
> -enum {
> -       MAX77686_CLK_AP = 0,
> -       MAX77686_CLK_CP,
> -       MAX77686_CLK_PMIC,
> -       MAX77686_CLKS_NUM,
> -};
> +#include <dt-bindings/clock/maxim,max77686.h>
>  
>  struct max77686_clk {
>         struct max77686_dev *iodev;
> diff --git a/include/dt-bindings/clock/maxim,max77686.h b/include/dt-bindings/clock/maxim,max77686.h
> new file mode 100644
> index 0000000..7b28b09
> --- /dev/null
> +++ b/include/dt-bindings/clock/maxim,max77686.h
> @@ -0,0 +1,23 @@
> +/*
> + * Copyright (C) 2014 Google, Inc
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Device Tree binding constants clocks for the Maxim 77686 PMIC.
> + */
> +
> +#ifndef _DT_BINDINGS_CLOCK_MAXIM_MAX77686_CLOCK_H
> +#define _DT_BINDINGS_CLOCK_MAXIM_MAX77686_CLOCK_H
> +
> +/* Fixed rate clocks. */
> +
> +#define MAX77686_CLK_AP                0
> +#define MAX77686_CLK_CP                1
> +#define MAX77686_CLK_PMIC      2
> +
> +/* Total number of clocks. */
> +#define MAX77686_CLKS_NUM              (MAX77686_CLK_PMIC + 1)
> +
> +#endif /* _DT_BINDINGS_CLOCK_MAXIM_MAX77686_CLOCK_H */
> -- 
> 2.0.0.rc2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
