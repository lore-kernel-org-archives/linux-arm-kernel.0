From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 18 Jul 2017 16:10:55 -0700
Subject: [PATCH 1/2] clk: imx: imx7d: Fix parent clock for OCRAM_CLK
In-Reply-To: <1500363892-1173-2-git-send-email-adriana.reus@nxp.com>
References: <1500363892-1173-1-git-send-email-adriana.reus@nxp.com>
 <1500363892-1173-2-git-send-email-adriana.reus@nxp.com>
Message-ID: <20170718231055.GG18179@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18, Adriana Reus wrote:
> The parent of OCRAM_CLK should be axi_main_root_clk
> and not axi_post_div.
> 
> before:
> 
>     axi_src                     1       1       332307692       0 0
>       axi_cg                    1       1       332307692       0 0
>         axi_pre_div             1       1       332307692       0 0
>           axi_post_div          1       1       332307692       0 0
>             ocram_clk           0       0       332307692       0 0
>             main_axi_root_clk   1       1       332307692       0 0
> 
> after:
> 
>     axi_src                     1       1       332307692       0 0
>       axi_cg                    1       1       332307692       0 0
>         axi_pre_div             1       1       332307692       0 0
>           axi_post_div          1       1       332307692       0 0
>             main_axi_root_clk   1       1       332307692       0 0
>               ocram_clk         0       0       332307692       0 0
> 
> Signed-off-by: Adriana Reus <adriana.reus@nxp.com>

Fixes: tag?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
