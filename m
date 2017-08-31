From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 30 Aug 2017 22:28:45 -0700
Subject: [PATCH 1/3] clk: ux500: prcmu: constify clk_ops.
In-Reply-To: <1503903761-21730-2-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503903761-21730-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1503903761-21730-2-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <20170831052845.GV21656@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28, Arvind Yadav wrote:
> clk_ops are not supposed to change at runtime. All functions
> working with clk_ops provided by <linux/clk-provider.h> work
> with const clk_ops. So mark the non-const clk_ops as const.
> 
> Here, Function "clk_reg_prcmu" is used to initialized clk_init_data.
> clk_init_data is working with const clk_ops. So make clk_reg_prcmu
> non-const clk_ops argument as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
