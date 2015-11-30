From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 30 Nov 2015 11:32:16 -0800
Subject: [PATCH] clk: sunxi: pll2: Fix clock running too fast
In-Reply-To: <1448897699-20475-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1448897699-20475-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20151130193216.GI11298@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30, Maxime Ripard wrote:
> @@ -191,25 +186,17 @@ err_unmap:
>  	iounmap(reg);
>  }
>  
> -static struct sun4i_pll2_data sun4i_a10_pll2_data = {
> -	.pre_div_flags	= CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
> -};
> -
>  static void __init sun4i_a10_pll2_setup(struct device_node *node)
>  {
> -	sun4i_pll2_setup(node, &sun4i_a10_pll2_data);
> +	sun4i_pll2_setup(node, &sun4i_a10_pll2_data, 0);

And it doesn't compile, because we just deleted the data that
this is taking an address of. Hmph.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
