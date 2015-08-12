From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 11 Aug 2015 17:27:58 -0700
Subject: [PATCH 6/7 v2] clk: atlas7: fix bit field and its root clk for
 coresight_tpiu
In-Reply-To: <1438699532-13860-7-git-send-email-21cnbao@gmail.com>
References: <1438699532-13860-1-git-send-email-21cnbao@gmail.com>
 <1438699532-13860-7-git-send-email-21cnbao@gmail.com>
Message-ID: <20150812002758.GG26614@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04, Barry Song wrote:
> diff --git a/drivers/clk/sirf/clk-atlas7.c b/drivers/clk/sirf/clk-atlas7.c
> index c1788df..4fc33da 100644
> --- a/drivers/clk/sirf/clk-atlas7.c
> +++ b/drivers/clk/sirf/clk-atlas7.c
> @@ -1164,7 +1164,7 @@ static struct atlas7_unit_init_data unit_list[] __initdata = {
>  	{ 122, "spram1_cpudiv2", "cpum_cpu", 0, SIRFSOC_CLKC_LEAF_CLK_EN6_SET, 0, &leaf6_gate_lock },
>  	{ 123, "spram2_cpudiv2", "cpum_cpu", 0, SIRFSOC_CLKC_LEAF_CLK_EN6_SET, 1, &leaf6_gate_lock },
>  	{ 124, "coresight_cpudiv2", "cpum_cpu", 0, SIRFSOC_CLKC_LEAF_CLK_EN6_SET, 2, &leaf6_gate_lock },
> -	{ 125, "thcpum_cpudiv4", "cpum_cpu", 0, SIRFSOC_CLKC_LEAF_CLK_EN6_SET, 3, &leaf6_gate_lock },
> +	{ 125 , "coresight_tpiu", "cpum_tpiu", 0, SIRFSOC_CLKC_LEAF_CLK_EN6_SET, 3, &leaf6_gate_lock },

This one too. Silenced checkpatch error by removing space after
125. Applied to clk-next.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
