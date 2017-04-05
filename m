From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 5 Apr 2017 12:43:13 -0700
Subject: [PATCH v4 2/3] clk: meson-gxbb: Add MALI clocks
In-Reply-To: <1490177935-9646-3-git-send-email-narmstrong@baylibre.com>
References: <1490177935-9646-1-git-send-email-narmstrong@baylibre.com>
 <1490177935-9646-3-git-send-email-narmstrong@baylibre.com>
Message-ID: <20170405194313.GM18246@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22, Neil Armstrong wrote:
> +/*
> + * The MALI IP is clocked by two identical clocks (mali_0 and mali_1)
> + * muxed by a glitch-free switch.
> + */
> +
> +static u32 mux_table_mali_0_1[] = {0, 1, 2, 3, 4, 5, 6, 7};
> +static const char *gxbb_mali_0_1_parent_names[] = {

const char * const?

> +	"xtal", "gp0_pll", "mpll2", "mpll1", "fclk_div7",
> +	"fclk_div4", "fclk_div3", "fclk_div5"
> +};
> +
[..]
> +	},
> +};
> +
> +static u32 mux_table_mali[] = {0, 1};
> +static const char *gxbb_mali_parent_names[] = {

It's a pattern, so I can only suspect something else is going on.

> +	"mali_0", "mali_1"
> +};
> +

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
