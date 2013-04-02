From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 02 Apr 2013 16:46:48 -0700
Subject: [PATCH v4] clk: add si5351 i2c common clock driver
In-Reply-To: <1364050010-23919-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1363603397-2762-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1364050010-23919-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130402234648.8177.86213@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sebastian Hesselbarth (2013-03-23 07:46:50)
> diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
> new file mode 100644
> index 0000000..9d0c210
> --- /dev/null
> +++ b/drivers/clk/clk-si5351.c
> @@ -0,0 +1,1411 @@
> +/*
> + * clk-si5351.c: Silicon Laboratories Si5351A/B/C I2C Clock Generator
> + *
> + * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> + * Rabeeh Khoury <rabeeh@solid-run.com>
> + *
> + * References:
> + * [1] "Si5351A/B/C Data Sheet"
> + *     http://www.silabs.com/Support%20Documents/TechnicalDocs/Si5351.pdf
> + * [2] "Manually Generating an Si5351 Register Map"
> + *     http://www.silabs.com/Support%20Documents/TechnicalDocs/AN619.pdf
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/clk-private.h>

I hope that this is supposed to be clk-provider.h.  I don't plan on
taking in any more clock drivers that depend on clk-private.h.  I didn't
see any reason for this patch to not use clk-provider.h.

Regards,
Mike
