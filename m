From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 24 Oct 2015 13:10:05 +0200
Subject: [PATCH v4 4/8] clk: rockchip: add new pll-type for rk3036 and
 similar socs
In-Reply-To: <1445682629-21632-5-git-send-email-zhengxing@rock-chips.com>
References: <1445682629-21632-1-git-send-email-zhengxing@rock-chips.com>
 <1445682629-21632-5-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1474048.ydSsx6D3zg@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Samstag, 24. Oktober 2015, 18:30:25 schrieb Xing Zheng:
> The rk3036's pll and clock are different with base on the rk3066(rk3188,
> rk3288, rk3368 use it), there are different adjust foctors and control
> registers, so these should be independent and separate from the series
> of rk3066s.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---
> 

> +static void rockchip_rk3036_pll_init(struct clk_hw *hw)
> +{

In the previous version, Stephen requested that we don't use regular clock
APIs in the init-callback. I did a modification for the already present pll-
type in [0], which got already accepted. So you should probably also modify
your pll-type in this fashion :-) .

Oh and I guess patches 3 and 4 should switch places ... adding the pll-type
before the code in the clock-controller using it.


Heiko


[0] https://git.kernel.org/cgit/linux/kernel/git/clk/linux.git/commit/?h=clk-next&id=8334c0e7b983fb27e0d8788901e9621d1946ba93
