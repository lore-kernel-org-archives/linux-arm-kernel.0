From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 17 Oct 2016 15:20:57 -0700
Subject: [PATCH] clk: uniphier: fix type of variable passed to
 regmap_read()
In-Reply-To: <1476631555-2059-1-git-send-email-yamada.masahiro@socionext.com>
References: <1476631555-2059-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20161017222057.GD8871@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17, Masahiro Yamada wrote:
> The 3rd argument of regmap_read() takes a pointer to unsigned int.
> This driver is saved just because u32 happens to be typedef'ed as
> unsigned int, but we should not rely on that fact.  Change the
> variable type just in case.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to clk-fixes

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
