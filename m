From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 04 Sep 2016 23:50:21 +0200
Subject: [v2 PATCH 1/3] clk: rockchip: Fractional dividers can't set
 parent rates
In-Reply-To: <1472786785-2393-1-git-send-email-zyw@rock-chips.com>
References: <1472786785-2393-1-git-send-email-zyw@rock-chips.com>
Message-ID: <3040422.nFj5Be1ODN@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 1. September 2016, 20:26:23 CEST schrieb Chris Zhong:
> From: Douglas Anderson <dianders@chromium.org>
> 
> Currently the fractional divider clock time can't handle the
> CLK_SET_RATE_PARENT flag. This is because, unlike normal dividers,
> there is no clk_divider_bestdiv() function to try speeding up the parent
> to see if it helps things.
> 
> Eventually someone could try to figure out how to make fractional
> dividers able to use CLK_SET_RATE_PARENT, but until they do let's not
> confuse the common clock framework (and anyone using it) by setting the
> flag.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>

applied to my clk-branch for 4.9, after changing the subject to
    clk: rockchip: drop CLK_SET_RATE_PARENT from rk3399 fractional dividers


Heiko
