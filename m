From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 17 Oct 2018 08:26:32 -0700
Subject: [PATCH 2/2] clk: imx7d: remove CLK_IS_CRITICAL flag for
 arm_a7_root_clk
In-Reply-To: <1539756441-18776-2-git-send-email-Anson.Huang@nxp.com>
References: <1539756441-18776-1-git-send-email-Anson.Huang@nxp.com>
 <1539756441-18776-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <153978999232.5275.9499110259610344794@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Anson Huang (2018-10-16 23:12:04)
> i.MX7D uses virtual cpu clock of "arm" clock to be child clock
> of "arm_a7_root_clk" and it is with CLK_IS_CRITICAL flag set, so
> no need to add CLK_IS_CRITICAL flag for keeping "arm_a7_root_clk"
> use count correct, latest clock tree is as below in clk_summary:
> 
> pll_arm_main                         1        1        0   792000000          0
>       pll_arm_main_bypass            1        1        0   792000000          0
>          pll_arm_main_clk            1        1        0   792000000          0
>             arm_a7_src               1        1        0   792000000          0
>                arm_a7_cg             1        1        0   792000000          0
>                   arm_a7_div         1        1        0   792000000          0
>                      arm_a7_root_clk       1        1        0   792000000    0
>                         arm          1        1        0   792000000
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next
