From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 25 Feb 2016 11:29:38 -0800
Subject: [PATCH v5 1/4] clk: sunxi: Add apb0 gates for H3
In-Reply-To: <1456146208-13890-2-git-send-email-k@japko.eu>
References: <1456146208-13890-1-git-send-email-k@japko.eu>
 <1456146208-13890-2-git-send-email-k@japko.eu>
Message-ID: <20160225192938.GL4736@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 22, 2016 at 02:03:25PM +0100, Krzysztof Adamski wrote:
> This patch adds support for APB0 in H3. It seems to be compatible with
> earlier SOCs. apb0 gates controls R_ block peripherals (R_PIO, R_IR,
> etc).
> 
> Signed-off-by: Krzysztof Adamski <k@japko.eu>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt | 2 ++
>  drivers/clk/sunxi/clk-simple-gates.c              | 4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index c09f59b..834436f 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -18,6 +18,7 @@ Required properties:
>  	"allwinner,sun4i-a10-cpu-clk" - for the CPU multiplexer clock
>  	"allwinner,sun4i-a10-axi-clk" - for the AXI clock
>  	"allwinner,sun8i-a23-axi-clk" - for the AXI clock on A23
> +	"allwinner,sun4i-a10-gates-clk" - for generic gates on all compatible SoCs
>  	"allwinner,sun4i-a10-axi-gates-clk" - for the AXI gates
>  	"allwinner,sun4i-a10-ahb-clk" - for the AHB clock
>  	"allwinner,sun5i-a13-ahb-clk" - for the AHB clock on A13
> @@ -46,6 +47,7 @@ Required properties:
>  	"allwinner,sun6i-a31-apb0-gates-clk" - for the APB0 gates on A31
>  	"allwinner,sun7i-a20-apb0-gates-clk" - for the APB0 gates on A20
>  	"allwinner,sun8i-a23-apb0-gates-clk" - for the APB0 gates on A23
> +	"allwinner,sun8i-h3-apb0-gates-clk" - for the APB0 gates on H3
>  	"allwinner,sun9i-a80-apb0-gates-clk" - for the APB0 gates on A80
>  	"allwinner,sun4i-a10-apb1-clk" - for the APB1 clock
>  	"allwinner,sun9i-a80-apb1-clk" - for the APB1 bus clock on A80
> diff --git a/drivers/clk/sunxi/clk-simple-gates.c b/drivers/clk/sunxi/clk-simple-gates.c
> index 2cfc5a8..d7ec2dc 100644
> --- a/drivers/clk/sunxi/clk-simple-gates.c
> +++ b/drivers/clk/sunxi/clk-simple-gates.c
> @@ -98,6 +98,8 @@ static void __init sunxi_simple_gates_init(struct device_node *node)
>  	sunxi_simple_gates_setup(node, NULL, 0);
>  }
>  
> +CLK_OF_DECLARE(sun4i_a10_gates, "allwinner,sun4i-a10-gates-clk",
> +	       sunxi_simple_gates_init);
>  CLK_OF_DECLARE(sun4i_a10_apb0, "allwinner,sun4i-a10-apb0-gates-clk",
>  	       sunxi_simple_gates_init);
>  CLK_OF_DECLARE(sun4i_a10_apb1, "allwinner,sun4i-a10-apb1-gates-clk",
> @@ -132,6 +134,8 @@ CLK_OF_DECLARE(sun8i_a33_ahb1, "allwinner,sun8i-a33-ahb1-gates-clk",
>  	       sunxi_simple_gates_init);
>  CLK_OF_DECLARE(sun8i_a83t_apb0, "allwinner,sun8i-a83t-apb0-gates-clk",
>  	       sunxi_simple_gates_init);
> +CLK_OF_DECLARE(sun8i_h3_apb0, "allwinner,sun8i-h3-apb0-gates-clk",
> +	       sunxi_simple_gates_init);

You don't need this one anymore. I removed it, and applied the patch.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160225/42ea11bb/attachment.sig>
