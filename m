From: Hong-Xing.Zhu@freescale.com (Hong-Xing.Zhu at freescale.com)
Date: Wed, 2 Apr 2014 12:57:25 +0000
Subject: [PATCH 1/8] ARM: imx6q-clk: parent lvds_gate from lvds_sel
In-Reply-To: <1396025579-14344-2-git-send-email-l.stach@pengutronix.de>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
 <1396025579-14344-2-git-send-email-l.stach@pengutronix.de>
Message-ID: <2d4c3e19ef3f4579a2cbdea70176e7d3@BLUPR03MB136.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas:
Thanks for your re-structure the management of the output on CLK1/2 pads.


> -----Original Message-----
> From: linux-pci-owner at vger.kernel.org [mailto:linux-pci-owner at vger.kernel.org]
> On Behalf Of Lucas Stach
> Sent: Saturday, March 29, 2014 12:53 AM
> To: linux-pci at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; linux-samsung-soc at vger.kernel.org;
> devicetree at vger.kernel.org; Sean Cross; Marek Vasut; Zhu Richard-R65037; Bjorn
> Helgaas; Jingoo Han; Shawn Guo; Ian Campbell; Mark Rutland; Pawel Moll; Rob
> Herring; Arnd Bergmann; Tim Harvey; kernel at pengutronix.de
> Subject: [PATCH 1/8] ARM: imx6q-clk: parent lvds_gate from lvds_sel
> 
> Allows fror proper refcounting of the parent clocks when enabling the clock
> output on CLK1/2 pads.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Acked-by: Richard Zhu <r65037@freescale.com>

> ---
>  arch/arm/mach-imx/clk-imx6q.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index af2e582d2b74..f98a6bb98145 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -208,8 +208,8 @@ static void __init imx6q_clocks_init(struct device_node
> *ccm_node)
>  	 * the "output_enable" bit as a gate, even though it's really just
>  	 * enabling clock output.
>  	 */
> -	clk[lvds1_gate] = imx_clk_gate("lvds1_gate", "dummy", base + 0x160, 10);
> -	clk[lvds2_gate] = imx_clk_gate("lvds2_gate", "dummy", base + 0x160, 11);
> +	clk[lvds1_gate] = imx_clk_gate("lvds1_gate", "lvds1_sel", base + 0x160,
> 10);
> +	clk[lvds2_gate] = imx_clk_gate("lvds2_gate", "lvds2_sel", base +
> +0x160, 11);
> 
>  	/*                                name              parent_name
> reg       idx */
>  	clk[pll2_pfd0_352m] = imx_clk_pfd("pll2_pfd0_352m", "pll2_bus",     base
> + 0x100, 0);
> --
> 1.9.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in the
> body of a message to majordomo at vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> 


Best Regards
Richard Zhu
