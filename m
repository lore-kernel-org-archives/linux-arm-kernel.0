From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 3 Feb 2016 15:04:25 +0800
Subject: [PATCH v2 1/5] clk: sunxi: Add apb0 gates for H3
In-Reply-To: <1454448113-18810-2-git-send-email-k@japko.eu>
References: <1454448113-18810-1-git-send-email-k@japko.eu>
 <1454448113-18810-2-git-send-email-k@japko.eu>
Message-ID: <CAGb2v65pKkXXsFg6Yki_OPBb7C0us5DDGBMtbOwb1tVR7oi9Uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 3, 2016 at 5:21 AM, Krzysztof Adamski <k@japko.eu> wrote:
> This patch adds support for APB0 in H3. It seems to be compatible with
> earlier SOCs. apb0 gates controls R_ block peripherals (R_PIO, R_IR,
> etc).
>
> Signed-off-by: Krzysztof Adamski <k@japko.eu>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt | 1 +
>  drivers/clk/sunxi/clk-simple-gates.c              | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index e59f57b..6ee6875 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -32,6 +32,7 @@ Required properties:
>         "allwinner,sun8i-h3-ahb2-clk" - for the AHB2 clock on H3
>         "allwinner,sun6i-a31-ahb1-gates-clk" - for the AHB1 gates on A31
>         "allwinner,sun8i-a23-ahb1-gates-clk" - for the AHB1 gates on A23
> +       "allwinner,sun8i-h3-abp0-gates-clk" - for the APB0 gates on H3

The list is grouped by clock type (AHB/APB/...) then family then SoC.
Please put this in the apb0 section below.

ChenYu

>         "allwinner,sun9i-a80-ahb0-gates-clk" - for the AHB0 gates on A80
>         "allwinner,sun9i-a80-ahb1-gates-clk" - for the AHB1 gates on A80
>         "allwinner,sun9i-a80-ahb2-gates-clk" - for the AHB2 gates on A80
> diff --git a/drivers/clk/sunxi/clk-simple-gates.c b/drivers/clk/sunxi/clk-simple-gates.c
> index f4da52b..8a1fa3e 100644
> --- a/drivers/clk/sunxi/clk-simple-gates.c
> +++ b/drivers/clk/sunxi/clk-simple-gates.c
> @@ -130,6 +130,8 @@ CLK_OF_DECLARE(sun8i_a23_apb2, "allwinner,sun8i-a23-apb2-gates-clk",
>                sunxi_simple_gates_init);
>  CLK_OF_DECLARE(sun8i_a33_ahb1, "allwinner,sun8i-a33-ahb1-gates-clk",
>                sunxi_simple_gates_init);
> +CLK_OF_DECLARE(sun8i_h3_abp0, "allwinner,sun8i-h3-abp0-gates-clk",
> +              sunxi_simple_gates_init);
>  CLK_OF_DECLARE(sun9i_a80_ahb0, "allwinner,sun9i-a80-ahb0-gates-clk",
>                sunxi_simple_gates_init);
>  CLK_OF_DECLARE(sun9i_a80_ahb1, "allwinner,sun9i-a80-ahb1-gates-clk",
> --
> 2.1.4
>
