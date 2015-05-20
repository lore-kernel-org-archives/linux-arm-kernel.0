From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 20 May 2015 09:51:55 +0800
Subject: [PATCH 1/1] ARM: imx: clk-v610: Add clock for I2C2 and I2C3
In-Reply-To: <1432038456-29706-1-git-send-email-mirza.krak@hostmobility.com>
References: <1432038456-29706-1-git-send-email-mirza.krak@hostmobility.com>
Message-ID: <20150520015155.GA1071@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 02:27:36PM +0200, Mirza Krak wrote:
> From: Mirza Krak <mirza.krak@gmail.com>
> 
> Add support for clock gating of I2C2 and I2C3.
> We use I2C2 in a (not yet mainlined) device tree.
> 
> Signed-off-by: Mirza Krak <mirza.krak@hostmobility.com>
> Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
> ---
>  arch/arm/mach-imx/clk-vf610.c | 2 ++

The file is being moved into drivers/clk/imx.  Please rebase your patch
on branch below:

 git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git imx/soc

Shawn

>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/clk-vf610.c b/arch/arm/mach-imx/clk-vf610.c
> index 5fcc4be..f5fff09 100644
> --- a/arch/arm/mach-imx/clk-vf610.c
> +++ b/arch/arm/mach-imx/clk-vf610.c
> @@ -279,6 +279,8 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
>  
>  	clk[VF610_CLK_I2C0] = imx_clk_gate2("i2c0", "ipg_bus", CCM_CCGR4, CCM_CCGRx_CGn(6));
>  	clk[VF610_CLK_I2C1] = imx_clk_gate2("i2c1", "ipg_bus", CCM_CCGR4, CCM_CCGRx_CGn(7));
> +	clk[VF610_CLK_I2C2] = imx_clk_gate2("i2c2", "ipg_bus", CCM_CCGR10, CCM_CCGRx_CGn(6));
> +	clk[VF610_CLK_I2C3] = imx_clk_gate2("i2c3", "ipg_bus", CCM_CCGR10, CCM_CCGRx_CGn(7));
>  
>  	clk[VF610_CLK_DSPI0] = imx_clk_gate2("dspi0", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(12));
>  	clk[VF610_CLK_DSPI1] = imx_clk_gate2("dspi1", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(13));
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
