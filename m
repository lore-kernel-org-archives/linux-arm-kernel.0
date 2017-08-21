From: david.wu@rock-chips.com (David.Wu)
Date: Mon, 21 Aug 2017 18:30:59 +0800
Subject: [PATCH v2 4/4] clk: rockchip: rv1108: fix up the clk_mac sel
 register description
In-Reply-To: <1503303367-17915-5-git-send-email-zhangqing@rock-chips.com>
References: <1503303367-17915-1-git-send-email-zhangqing@rock-chips.com>
 <1503303367-17915-5-git-send-email-zhangqing@rock-chips.com>
Message-ID: <2f6cae9a-b595-453f-1fd3-1858f7774cd9@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Elaine,

? 2017/8/21 16:16, Elaine Zhang ??:
> cru_sel24_con[8]
> rmii_extclk_sel
> clock source select control register
> 1'b0: from internal PLL
> 1'b1: from external IO
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>   drivers/clk/rockchip/clk-rv1108.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/rockchip/clk-rv1108.c b/drivers/clk/rockchip/clk-rv1108.c
> index 658da17c9d99..4d87828df4f7 100644
> --- a/drivers/clk/rockchip/clk-rv1108.c
> +++ b/drivers/clk/rockchip/clk-rv1108.c
> @@ -140,7 +140,7 @@ enum rv1108_plls {
>   PNAME(mux_uart0_p)		= { "uart0_src", "uart0_frac", "xin24m" };
>   PNAME(mux_uart1_p)		= { "uart1_src", "uart1_frac", "xin24m" };
>   PNAME(mux_uart2_p)		= { "uart2_src", "uart2_frac", "xin24m" };
> -PNAME(mux_sclk_mac_p)	= { "ext_gmac", "sclk_mac_pre" };
> +PNAME(mux_sclk_mac_p)	= { "sclk_mac_pre", "ext_gmac" };
>   PNAME(mux_i2s0_pre_p)		= { "i2s0_src", "i2s0_frac", "ext_i2s", "xin12m" };
>   PNAME(mux_i2s_out_p)		= { "i2s0_pre", "xin12m" };
>   PNAME(mux_i2s1_p)		= { "i2s1_src", "i2s1_frac", "dummy", "xin12m" };
> 

Acked-by: David Wu <david.wu@rock-chips.com>
