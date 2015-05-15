From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 15 May 2015 11:37:07 -0700
Subject: [PATCH] clk: mediatek: Initialize clk flags
In-Reply-To: <1431670969-1996-1-git-send-email-jcliang@chromium.org>
References: <1431670969-1996-1-git-send-email-jcliang@chromium.org>
Message-ID: <20150515183707.GM31753@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15, Ricky Liang wrote:
> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> index 66154ca..72fe307 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -289,6 +289,7 @@ static struct clk *mtk_clk_register_pll(const struct mtk_pll_data *data,
>  	init.ops = &mtk_pll_ops;
>  	init.parent_names = &parent_name;
>  	init.num_parents = 1;
> +	init.flags = data->flags;

Wrong? It looks like plls[] in drivers/clk/mediatek/clk-mt8135.c
is putting mtk specific clock flags in this structure member.

How about initializing the structure to { } instead? That way if
we ever add more structure members we don't have to detect the
landmine laid here.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
