From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 22 May 2018 15:56:01 +0200
Subject: [PATCH 13/33] clk: rockchip: use match_string() helper
In-Reply-To: <1526903890-35761-14-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-14-git-send-email-xieyisheng1@huawei.com>
Message-ID: <3184431.yyZBj8V0y7@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 21. Mai 2018, 13:57:50 CEST schrieb Yisheng Xie:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-clk at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-rockchip at lists.infradead.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>

> @@ -312,6 +304,8 @@ static struct clk *rockchip_clk_register_frac_branch(
>  
>  		/* notifier on the fraction divider to catch rate changes */
>  		if (frac->mux_frac_idx >= 0) {
> +			pr_debug("%s: find fractional parent in mux at pos %d\n",
> +				 __func__, frac->mux_frac_idx);

applied to my Rockchip clk branch for 4.18 after changing the "find" above
to "found" again ;-) .


Thanks for the nice cleanup
Heiko
