From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 29 May 2014 16:10:56 +0800
Subject: [PATCH] ARM: clk: imx: remove the CLK_SET_RATE_NO_REPARENT for
 imx_clk_mux_flags
In-Reply-To: <1401089474-14346-1-git-send-email-b32955@freescale.com>
References: <1401089474-14346-1-git-send-email-b32955@freescale.com>
Message-ID: <20140529081055.GG8860@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 03:31:14PM +0800, Huang Shijie wrote:
> The clocks for Quadspi controller may be different when different
> NOR flashes are connected to the board.
> 
> But the CLK_SET_RATE_NO_REPARENT flag in the current imx_clk_mux_flags
> makes the clock do not have the re-parent capability.
> 
> This patch removes the CLK_SET_RATE_NO_REPARENT for imx_clk_mux_flags.
> It makes the Quadspi happy.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Applied it for now.  Let's if the change will cause any issue on
linux-next.

Shawn

> ---
>  arch/arm/mach-imx/clk.h |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk.h b/arch/arm/mach-imx/clk.h
> index e29f6eb..32d6253 100644
> --- a/arch/arm/mach-imx/clk.h
> +++ b/arch/arm/mach-imx/clk.h
> @@ -108,8 +108,7 @@ static inline struct clk *imx_clk_mux_flags(const char *name,
>  		int num_parents, unsigned long flags)
>  {
>  	return clk_register_mux(NULL, name, parents, num_parents,
> -			flags | CLK_SET_RATE_NO_REPARENT, reg, shift, width, 0,
> -			&imx_ccm_lock);
> +			flags, reg, shift, width, 0, &imx_ccm_lock);
>  }
>  
>  static inline struct clk *imx_clk_fixed_factor(const char *name,
> -- 
> 1.7.8
> 
