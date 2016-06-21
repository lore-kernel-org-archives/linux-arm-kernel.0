From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 20 Jun 2016 18:15:37 -0700
Subject: [PATCH v2 04/15] clk: sunxi-ng: Add fixed factor clock support
In-Reply-To: <20160607204154.31967-5-maxime.ripard@free-electrons.com>
References: <20160607204154.31967-1-maxime.ripard@free-electrons.com>
 <20160607204154.31967-5-maxime.ripard@free-electrons.com>
Message-ID: <20160621011537.GP1521@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07, Maxime Ripard wrote:
> +
> +#include <linux/clk-provider.h>
> +
> +#include "ccu_common.h"
> +
> +struct ccu_fixed_factor {
> +	u16			div;
> +	u16			mult;
> +
> +	struct ccu_common	common;

Does this use the common structure although we have no usage for
the members of struct ccu_common except struct clk_hw? I suppose
this is done so registering a bunch of clks is easy?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
