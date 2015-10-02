From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 2 Oct 2015 13:45:55 -0700
Subject: [PATCH v3 5/5] clk: sunxi: mod1 clock support
In-Reply-To: <1443512353-28073-6-git-send-email-maxime.ripard@free-electrons.com>
References: <1443512353-28073-1-git-send-email-maxime.ripard@free-electrons.com>
 <1443512353-28073-6-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20151002204555.GA12338@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/29, Maxime Ripard wrote:
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>

Is this include used?

> +	if (!gate)
> +		goto err_free_mux;
> +
> +	of_property_read_string(node, "clock-output-names", &clk_name);
> +
> +	while (i < SUN4I_MOD1_MAX_PARENTS &&
> +	       (parents[i] = of_clk_get_parent_name(node, i)) != NULL)

Can we use of_clk_parent_fill() here?

> +		i++;
> +

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
