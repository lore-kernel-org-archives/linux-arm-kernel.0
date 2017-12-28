From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 28 Dec 2017 15:16:12 -0800
Subject: [PATCH] clk: divider: fix incorrect usage of container_of
In-Reply-To: <20171221163054.13600-1-jbrunet@baylibre.com>
References: <20171221163054.13600-1-jbrunet@baylibre.com>
Message-ID: <20171228231612.GX7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/21, Jerome Brunet wrote:
> divider_recalc_rate() is an helper function used by clock divider of
> different types, so the structure containing the 'hw' pointer is not
> always a 'struct clk_divider'
> 
> At the following line:
> > div = _get_div(table, val, flags, divider->width);
> 
> in several cases, the value of 'divider->width' is garbage as the actual
> structure behind this memory is not a 'struct clk_divider'
> 
> Fortunately, this width value is used by _get_val() only when
> CLK_DIVIDER_MAX_AT_ZERO flag is set. This has never been the case so
> far when the structure is not a 'struct clk_divider'. This is probably
> why we did not notice this bug before
> 
> Fixes: afe76c8fd030 ("clk: allow a clk divider with max divisor when zero")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
