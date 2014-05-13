From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 12 May 2014 18:32:08 -0700
Subject: [PATCH v3 1/8] clk: sunxi: Implement A31 USB clock
In-Reply-To: <1399923274-6017-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1399923274-6017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1399923274-6017-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140513013208.5943.89944@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Maxime Ripard (2014-05-12 12:34:27)
> The A31 USB clock slightly differ from its older counterparts, mostly because
> it has a different gate for each PHY, while the older one had a single gate for
> all the phy.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Mike Turquette <mturquette@linaro.org>

> ---
>  drivers/clk/sunxi/clk-sunxi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index bd7dc733c1ca..d9bab75f128b 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -972,6 +972,11 @@ static const struct gates_data sun5i_a13_usb_gates_data __initconst = {
>         .reset_mask = 0x03,
>  };
>  
> +static const struct gates_data sun6i_a31_usb_gates_data __initconst = {
> +       .mask = { BIT(18) | BIT(17) | BIT(16) | BIT(10) | BIT(9) | BIT(8) },
> +       .reset_mask = BIT(2) | BIT(1) | BIT(0),
> +};
> +
>  static void __init sunxi_gates_clk_setup(struct device_node *node,
>                                          struct gates_data *data)
>  {
> @@ -1267,6 +1272,7 @@ static const struct of_device_id clk_gates_match[] __initconst = {
>         {.compatible = "allwinner,sun6i-a31-apb2-gates-clk", .data = &sun6i_a31_apb2_gates_data,},
>         {.compatible = "allwinner,sun4i-a10-usb-clk", .data = &sun4i_a10_usb_gates_data,},
>         {.compatible = "allwinner,sun5i-a13-usb-clk", .data = &sun5i_a13_usb_gates_data,},
> +       {.compatible = "allwinner,sun6i-a31-usb-clk", .data = &sun6i_a31_usb_gates_data,},
>         {}
>  };
>  
> -- 
> 1.9.3
> 
