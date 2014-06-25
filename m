From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 25 Jun 2014 12:18:52 +0200
Subject: [PATCH v3 03/14] clk: max77686: Add DT include for MAX77686 PMIC
 clock
In-Reply-To: <1403202040-12641-4-git-send-email-javier.martinez@collabora.co.uk>
References: <1403202040-12641-1-git-send-email-javier.martinez@collabora.co.uk>
 <1403202040-12641-4-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1403691532.22107.8.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On czw, 2014-06-19 at 20:20 +0200, Javier Martinez Canillas wrote:
> This patch adds a dt-binding include for Maxim 77686
> PMIC clock IDs that can be to be shared between the
> clk-max77686 clock driver and DeviceTree source files.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  drivers/clk/clk-max77686.c                 |  7 +------
>  include/dt-bindings/clock/maxim,max77686.h | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+), 6 deletions(-)
>  create mode 100644 include/dt-bindings/clock/maxim,max77686.h

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

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
> -	MAX77686_CLK_AP = 0,
> -	MAX77686_CLK_CP,
> -	MAX77686_CLK_PMIC,
> -	MAX77686_CLKS_NUM,
> -};
> +#include <dt-bindings/clock/maxim,max77686.h>
>  
>  struct max77686_clk {
>  	struct max77686_dev *iodev;
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
> +#define MAX77686_CLK_AP		0
> +#define MAX77686_CLK_CP		1
> +#define MAX77686_CLK_PMIC	2
> +
> +/* Total number of clocks. */
> +#define MAX77686_CLKS_NUM		(MAX77686_CLK_PMIC + 1)
> +
> +#endif /* _DT_BINDINGS_CLOCK_MAXIM_MAX77686_CLOCK_H */
