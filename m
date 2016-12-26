From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 26 Dec 2016 12:17:06 +0100
Subject: [PATCH v3 4/4] clk: rockchip: add new pll-type for rk3328
In-Reply-To: <1482723930-5876-5-git-send-email-zhangqing@rock-chips.com>
References: <1482723930-5876-1-git-send-email-zhangqing@rock-chips.com>
 <1482723930-5876-5-git-send-email-zhangqing@rock-chips.com>
Message-ID: <30891453.yaZWColTmb@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 26. Dezember 2016, 11:45:30 CET schrieb Elaine Zhang:
> The rk3328's pll and clock are similar with rk3036's,
> it different with pll_mode_mask, the rk3328 soc
> pll mode only one bit(rk3036 soc have two bits)
> so these should be independent and separate from
> the series of rk3328s.
> 
> Changes in v3:
>   fix up the pll type pll_rk3328 description and use
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---

pll-specific code looks good now, but please make this patch before the clock 
controller in the series and move the 

@@ -130,6 +152,7 @@
 enum rockchip_pll_type {
        pll_rk3036,
        pll_rk3066,
+       pll_rk3328,
        pll_rk3399,
 };
 
from patch3 into this one.


Thanks
Heiko

PS: I will have some comments for the clock controller patch, but it's xmas, 
so that may take bit still.
