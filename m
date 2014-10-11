From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 11 Oct 2014 20:32:28 +0200
Subject: [PATCH] clk: rockchip: fix parent for spdif_8ch_frac on rk3288
In-Reply-To: <1412758516-18285-1-git-send-email-sonnyrao@chromium.org>
References: <1412758516-18285-1-git-send-email-sonnyrao@chromium.org>
Message-ID: <2955697.uCN2kRtiKs@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sonny,

Am Mittwoch, 8. Oktober 2014, 01:55:16 schrieb Sonny Rao:
> The parent should be spdif_8ch_pre not spdif_8ch_src, which doesn't
> exist and looks to be a typo.  The TRM also confirms this.

thanks for the catch. I've added the patch to a temporary branch for 3.19 till 
we have a stable 3.18-rc1.

As nothing uses the spdif so far I don't think we'll need the fix for 3.18 
itself. Please holler if you think otherwise :-)


Heiko

> 
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> ---
>  drivers/clk/rockchip/clk-rk3288.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3288.c
> b/drivers/clk/rockchip/clk-rk3288.c index 2327829..e41ae1f 100644
> --- a/drivers/clk/rockchip/clk-rk3288.c
> +++ b/drivers/clk/rockchip/clk-rk3288.c
> @@ -325,7 +325,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[]
> __initdata = { COMPOSITE_NOMUX(0, "spdif_8ch_pre", "spdif_src", 0,
>  			RK3288_CLKSEL_CON(40), 0, 7, DFLAGS,
>  			RK3288_CLKGATE_CON(4), 7, GFLAGS),
> -	COMPOSITE_FRAC(0, "spdif_8ch_frac", "spdif_8ch_src", 0,
> +	COMPOSITE_FRAC(0, "spdif_8ch_frac", "spdif_8ch_pre", 0,
>  			RK3288_CLKSEL_CON(41), 0,
>  			RK3288_CLKGATE_CON(4), 8, GFLAGS),
>  	COMPOSITE_NODIV(SCLK_SPDIF8CH, "sclk_spdif_8ch", mux_spdif_8ch_p, 0,
