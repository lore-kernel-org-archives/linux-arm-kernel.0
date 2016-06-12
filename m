From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 12 Jun 2016 19:43:53 +0800
Subject: [PATCH 07/11] clk: imx6ul: fix pll clock parents
In-Reply-To: <1465396420-27064-7-git-send-email-aisheng.dong@nxp.com>
References: <1465396420-27064-1-git-send-email-aisheng.dong@nxp.com>
 <1465396420-27064-7-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20160612114353.GE20243@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 10:33:36PM +0800, Dong Aisheng wrote:
> pllx_bypass_src mux shouldn't be the parent of pllx clock
> since it's only valid when when pllx BYPASS bit is set.
> Thus it is actually one parent of pllx_bypass only.
> 
> Instead, pllx parent should be fixed to osc according to
> reference manual.
> Other plls have the same issue.
> 
> e.g. before fix, the pll tree is:
> osc                                      6            6    24000000          0 0
>    pll1_bypass_src                       0            0    24000000          0 0
>       pll1                               0            0   792000000          0 0
>          pll1_bypass                     0            0   792000000          0 0
>             pll1_sys                     0            0   792000000          0 0
> 
> After the fix, it's:
> osc                                      6            6    24000000          0 0
>    pll1                                  0            0   792000000          0 0
>       pll1_bypass                        0            0   792000000          0 0
>          pll1_sys                        0            0   792000000          0 0
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

I squashed 7 ~ 11 into one patch and applied it, thanks.

Shawn
