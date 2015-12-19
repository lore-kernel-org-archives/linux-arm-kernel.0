From: robh@kernel.org (Rob Herring)
Date: Fri, 18 Dec 2015 22:05:10 -0600
Subject: [PATCH v3 1/3] ARM: sunxi: Introduce Allwinner for A83T support
In-Reply-To: <1450445451-311-2-git-send-email-vishnupatekar0510@gmail.com>
References: <1450445451-311-1-git-send-email-vishnupatekar0510@gmail.com>
 <1450445451-311-2-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <20151219040252.GA4997@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 09:30:49PM +0800, Vishnu Patekar wrote:
> Allwinner A83T is octa-core cortex-a7 based SoC.
> It's clock control unit and prcm, pinmux are different from previous sun8i
> series.
> Its processor cores are arragned in two clusters 4 cores each,
> similar to A80.
> 
> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/arm/sunxi/README                  | 1 -
>  Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
>  arch/arm/mach-sunxi/sunxi.c                     | 1 +
>  drivers/clk/sunxi/clk-sunxi.c                   | 6 ++++++
>  4 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arm/sunxi/README b/Documentation/arm/sunxi/README
> index 430d279..e5a115f 100644
> --- a/Documentation/arm/sunxi/README
> +++ b/Documentation/arm/sunxi/README
> @@ -72,6 +72,5 @@ SunXi family
>  
>      * Octa ARM Cortex-A7 based SoCs
>        - Allwinner A83T
> -        + Not Supported
>          + Datasheet
>            http://dl.linux-sunxi.org/A83T/A83T_datasheet_Revision_1.1.pdf
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
> index bb9b0faa..7e79fcc 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.txt
> +++ b/Documentation/devicetree/bindings/arm/sunxi.txt
> @@ -11,5 +11,6 @@ using one of the following compatible strings:
>    allwinner,sun7i-a20
>    allwinner,sun8i-a23
>    allwinner,sun8i-a33
> +  allwinner,sun8i-a83t
>    allwinner,sun8i-h3
>    allwinner,sun9i-a80
> diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> index c2be98f..3c15619 100644
> --- a/arch/arm/mach-sunxi/sunxi.c
> +++ b/arch/arm/mach-sunxi/sunxi.c
> @@ -69,6 +69,7 @@ MACHINE_END
>  static const char * const sun8i_board_dt_compat[] = {
>  	"allwinner,sun8i-a23",
>  	"allwinner,sun8i-a33",
> +	"allwinner,sun8i-a83t",
>  	"allwinner,sun8i-h3",
>  	NULL,
>  };
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 5ba2188..0d45253 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -1219,6 +1219,12 @@ CLK_OF_DECLARE(sun8i_a23_clk_init, "allwinner,sun8i-a23", sun6i_init_clocks);
>  CLK_OF_DECLARE(sun8i_a33_clk_init, "allwinner,sun8i-a33", sun6i_init_clocks);
>  CLK_OF_DECLARE(sun8i_h3_clk_init, "allwinner,sun8i-h3", sun6i_init_clocks);
>  
> +static void __init sun8i_a83t_init_clocks(struct device_node *node)
> +{
> +	sunxi_init_clocks(NULL, 0);
> +}
> +CLK_OF_DECLARE(sun8i_a83t_clk_init, "allwinner,sun8i-a83t", sun8i_a83t_init_clocks);
> +
>  static void __init sun9i_init_clocks(struct device_node *node)
>  {
>  	sunxi_init_clocks(NULL, 0);
> -- 
> 1.9.1
> 
