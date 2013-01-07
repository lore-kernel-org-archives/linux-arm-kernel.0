From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 7 Jan 2013 14:13:47 +0200
Subject: [PATCH v2 01/11] clk: tegra: Add tegra specific clocks
In-Reply-To: <1356619644-18565-2-git-send-email-pgaikwad@nvidia.com>
References: <1356619644-18565-1-git-send-email-pgaikwad@nvidia.com>
 <1356619644-18565-2-git-send-email-pgaikwad@nvidia.com>
Message-ID: <20130107121347.GG26066@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 27, 2012 at 03:47:14PM +0100, Prashant Gaikwad wrote:
> Add tegra specific clocks, pll, pll_out, peripheral,
> frac_divider, super.
> 

...

> diff --git a/drivers/clk/tegra/clk-pll-out.c b/drivers/clk/tegra/clk-pll-out.c
> new file mode 100644
> index 0000000..60a117b
> --- /dev/null
> +++ b/drivers/clk/tegra/clk-pll-out.c
> @@ -0,0 +1,124 @@
> +/*
> + * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clk.h>
> +
> +#include "clk.h"
> +
> +#define to_clk_pll_out(_hw) container_of(_hw, struct tegra_clk_pll_out, hw)
> +
> +#define pll_out_enb(p) (BIT(p->enb_bit_idx))
> +#define pll_out_rst(p) (BIT(p->rst_bit_idx))
> +

Given that these 2 are always consecutive bits, wouldn't it make more sense to
specify the bit offset once and then add 1 for the enable bit?

Cheers,

Peter.
