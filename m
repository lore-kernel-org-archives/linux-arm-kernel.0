From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 06 Jul 2018 09:50:51 -0700
Subject: [PATCH v3 3/4] clk: rockchip: add support for half divider
In-Reply-To: <1529029011-15021-4-git-send-email-zhangqing@rock-chips.com>
References: <1529029011-15021-1-git-send-email-zhangqing@rock-chips.com>
 <1529029011-15021-4-git-send-email-zhangqing@rock-chips.com>
Message-ID: <153089585197.143105.10633953093490493144@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Elaine Zhang (2018-06-14 19:16:50)
> 
> diff --git a/drivers/clk/rockchip/clk-half-divider.c b/drivers/clk/rockchip/clk-half-divider.c
> new file mode 100644
> index 000000000000..fb7a6501e0c1
> --- /dev/null
> +++ b/drivers/clk/rockchip/clk-half-divider.c
> @@ -0,0 +1,230 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 Fuzhou Rockchip Electronics Co., Ltd
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/bitops.h>
> +#include <linux/regmap.h>
> +#include <linux/clk.h>

Is this include used?

> +#include <linux/clk-provider.h>
> +#include "clk.h"
