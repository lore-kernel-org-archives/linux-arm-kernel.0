From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 26 Mar 2013 12:47:41 -0700
Subject: [PATCH] ARM: mach-imx: clk-busy: Adapt to new the clk_mux
 structure
In-Reply-To: <1364305330-21638-1-git-send-email-fabio.estevam@freescale.com>
References: <1364305330-21638-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20130326194741.4014.86133@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Fabio Estevam (2013-03-26 06:42:10)
> Commit ce4f3313b05 (clk: add table lookup to mux) caused the following build 
> error on imx_v4_v5_defconfig/imx_v6_v7_defconfig:
> 
> arch/arm/mach-imx/clk-busy.c:172:11: error: 'struct clk_mux' has no member named 'width'
> 
> Fix it by passing the 'mask' field.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Oops!  I just sent the same patch to the list.  I'll take yours into
clk-next since you were first Fabio ;-)

Thanks,
Mike

> ---
>  arch/arm/mach-imx/clk-busy.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/clk-busy.c b/arch/arm/mach-imx/clk-busy.c
> index 1ab91b5..85b728c 100644
> --- a/arch/arm/mach-imx/clk-busy.c
> +++ b/arch/arm/mach-imx/clk-busy.c
> @@ -169,7 +169,7 @@ struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift,
>  
>         busy->mux.reg = reg;
>         busy->mux.shift = shift;
> -       busy->mux.width = width;
> +       busy->mux.mask = BIT(width) - 1;
>         busy->mux.lock = &imx_ccm_lock;
>         busy->mux_ops = &clk_mux_ops;
>  
> -- 
> 1.7.9.5
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
