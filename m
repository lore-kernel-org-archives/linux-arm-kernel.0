From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 19 Oct 2016 13:14:21 -0700
Subject: [PATCH] clk: uniphier: fix memory overrun bug
In-Reply-To: <1476877779-27854-1-git-send-email-yamada.masahiro@socionext.com>
References: <1476877779-27854-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20161019201421.GY8871@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19, Masahiro Yamada wrote:
> The first loop of this "for" statement writes memory beyond the
> allocated clk_hw_onecell_data.
> 
> It should be:
>     for (clk_num--; clk_num >= 0; clk_num--)
>             ...
> 
> Or more simply:
>     while (--clk_num >= 0)
>             ...
> 
> Fixes: 734d82f4a678 ("clk: uniphier: add core support code for UniPhier clock driver")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to clk-fixes

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
