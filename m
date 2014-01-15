From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 14 Jan 2014 21:37:06 -0800
Subject: [PATCH v2] clk: sirf: re-arch to make the codes support both
 prima2 and atlas6
In-Reply-To: <1388986699-6470-1-git-send-email-21cnbao@gmail.com>
References: <1388986699-6470-1-git-send-email-21cnbao@gmail.com>
Message-ID: <20140115053706.4167.23616@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Barry Song (2014-01-05 21:38:19)
> diff --git a/drivers/clk/sirf/clk-atlas6.c b/drivers/clk/sirf/clk-atlas6.c
> new file mode 100644
> index 0000000..21e776a
> --- /dev/null
> +++ b/drivers/clk/sirf/clk-atlas6.c
> @@ -0,0 +1,153 @@
> +/*
> + * Clock tree for CSR SiRFatlasVI
> + *
> + * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
> + *
> + * Licensed under GPLv2 or later.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/bitops.h>
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/clk-private.h>

Please do not use clk-private.h. It is slated for removal (some day...).
Do you actually need it?

Regards,
Mike
