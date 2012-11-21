From: mturquette@ti.com (Mike Turquette)
Date: Wed, 21 Nov 2012 11:08:52 -0800
Subject: [PATCH 1/3] clk: add GPLv2 headers to the Versatile clock files
In-Reply-To: <1353447571-12876-1-git-send-email-linus.walleij@linaro.org>
References: <1353447571-12876-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20121121190852.21126.46977@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Linus Walleij (2012-11-20 13:39:31)
> The GPLv2 headers were missing and the subsystem maintainer likes
> them so put them in. I am the copyright holder, so explicitly
> licensing these under the GPLv2.
> 
> Reported-by: Mike Turquette <mturquette@ti.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Taken into clk-next.

Thanks,
Mike

> ---
>  drivers/clk/versatile/clk-icst.c       |  6 ++++++
>  drivers/clk/versatile/clk-integrator.c | 10 +++++++++-
>  drivers/clk/versatile/clk-realview.c   |  8 ++++++++
>  3 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/versatile/clk-icst.c b/drivers/clk/versatile/clk-icst.c
> index f555b50..23d2d7e 100644
> --- a/drivers/clk/versatile/clk-icst.c
> +++ b/drivers/clk/versatile/clk-icst.c
> @@ -3,6 +3,12 @@
>   * We wrap the custom interface from <asm/hardware/icst.h> into the generic
>   * clock framework.
>   *
> + * Copyright (C) 2012 Linus Walleij
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
>   * TODO: when all ARM reference designs are migrated to generic clocks, the
>   * ICST clock code from the ARM tree should probably be merged into this
>   * file.
> diff --git a/drivers/clk/versatile/clk-integrator.c b/drivers/clk/versatile/clk-integrator.c
> index a505392..3c816ae 100644
> --- a/drivers/clk/versatile/clk-integrator.c
> +++ b/drivers/clk/versatile/clk-integrator.c
> @@ -1,8 +1,16 @@
> +/*
> + * Clock driver for the ARM Integrator/AP and Integrator/CP boards
> + * Copyright (C) 2012 Linus Walleij
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/clk-provider.h>
>  #include <linux/clk.h>
>  #include <linux/clkdev.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> -#include <linux/clk-provider.h>
>  
>  #include <mach/hardware.h>
>  #include <mach/platform.h>
> diff --git a/drivers/clk/versatile/clk-realview.c b/drivers/clk/versatile/clk-realview.c
> index e21a99c..fd2dbdb 100644
> --- a/drivers/clk/versatile/clk-realview.c
> +++ b/drivers/clk/versatile/clk-realview.c
> @@ -1,3 +1,11 @@
> +/*
> + * Clock driver for the ARM RealView boards
> + * Copyright (C) 2012 Linus Walleij
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
>  #include <linux/clk.h>
>  #include <linux/clkdev.h>
>  #include <linux/err.h>
> -- 
> 1.7.11.7
