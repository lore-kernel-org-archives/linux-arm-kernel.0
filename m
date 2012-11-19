From: mturquette@ti.com (Mike Turquette)
Date: Mon, 19 Nov 2012 12:02:38 -0800
Subject: [PATCH] clk: move IM-PD1 clocks to drivers/clk
In-Reply-To: <1353350711-29916-1-git-send-email-linus.walleij@linaro.org>
References: <1353350711-29916-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20121119200238.21126.61661@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Linus Walleij (2012-11-19 10:45:11)
> diff --git a/drivers/clk/versatile/clk-impd1.c b/drivers/clk/versatile/clk-impd1.c
> new file mode 100644
> index 0000000..28ac702
> --- /dev/null
> +++ b/drivers/clk/versatile/clk-impd1.c
> @@ -0,0 +1,96 @@

What is rule on GPL headers these days?  I notice that this file is
missing as well as some of the other C files in drivers/clk/versatile/.

I prefer to have GPL headers and also establishing a copyright owner,
but maybe I'm out of touch with some new way of doing things?

> +#include <linux/clk-provider.h>
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/platform_data/clk-integrator.h>
> +

<snip>

> diff --git a/drivers/clk/versatile/clk-integrator.c b/drivers/clk/versatile/clk-integrator.c
> index a505392..5aa6ab9 100644
> --- a/drivers/clk/versatile/clk-integrator.c
> +++ b/drivers/clk/versatile/clk-integrator.c
> @@ -1,8 +1,9 @@

Same here.  I guess I didn't catch this the first time around.

Rest of the patch looks fine so once the header question is answered
I'll either take it or you can respin with the headers.

Regards,
Mike
