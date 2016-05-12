From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 12 May 2016 14:47:02 -0700
Subject: [linux-sunxi] Re: [PATCH v4 01/11] clk: sunxi: Add display and
 TCON0 clocks driver
In-Reply-To: <20160512083047.GY3733@lukather>
References: <1461590572-4027-2-git-send-email-maxime.ripard@free-electrons.com>
 <20160506223002.GE3492@codeaurora.org>
 <20160508200308.GF6167@lukather>
 <20160509223238.GW3492@codeaurora.org>
 <20160509223924.GX3492@codeaurora.org>
 <1462907459.9981.0.camel@plaes.org>
 <20160511221541.GG3492@codeaurora.org>
 <1463024360.16747.4.camel@plaes.org>
 <20160512065943.GX3733@lukather> <20160512083047.GY3733@lukather>
Message-ID: <20160512214702.GL3492@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12, Maxime Ripard wrote:
> 
> diff --git a/drivers/clk/sunxi/clk-sun4i-display.c b/drivers/clk/sunxi/clk-sun4i-display.c
> index 70803aa7028c..9780fac6d029 100644
> --- a/drivers/clk/sunxi/clk-sun4i-display.c
> +++ b/drivers/clk/sunxi/clk-sun4i-display.c
> @@ -128,8 +128,8 @@ static void __init sun4i_a10_display_init(struct device_node *node,
>  		return;
>  	}
>  
> -	ret = of_clk_parent_fill(node, parents, ARRAY_SIZE(parents));
> -	if (ret != ARRAY_SIZE(parents)) {
> +	ret = of_clk_parent_fill(node, parents, data->parents);
> +	if (ret != data->parents) {
>  		pr_err("%s: Could not retrieve the parents\n", clk_name);
>  		goto unmap;
>  	}

Ah ok. Thanks for catching that thinko and sending a patch.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
