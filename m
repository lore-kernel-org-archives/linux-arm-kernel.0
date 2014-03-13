From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 13 Mar 2014 17:31:28 +0000
Subject: [PATCH v3 1/2] i2c: sunxi: Change i2c compatibles
In-Reply-To: <1394710643-3411-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1394710643-3411-1-git-send-email-maxime.ripard@free-electrons.com>
 <1394710643-3411-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140313173128.GC25870@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 11:37:22AM +0000, Maxime Ripard wrote:
> The Allwinner A10 compatibles were following a slightly different compatible
> patterns than the rest of the SoCs for historical reasons. Move to the other
> pattern for consistency across all Allwinner Socs.

Dropping support for the existing string breaks existing DTBs. Is this
really necessary?

Thanks,
Mark.

> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 2 +-
>  drivers/i2c/busses/i2c-mv64xxx.c                      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> index befd4fb4764f..5c30026921ae 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> @@ -5,7 +5,7 @@ Required properties :
>  
>   - reg             : Offset and length of the register set for the device
>   - compatible      : Should be either:
> -                     - "allwinner,sun4i-i2c"
> +                     - "allwinner,sun4i-a10-i2c"
>                       - "allwinner,sun6i-a31-i2c"
>                       - "marvell,mv64xxx-i2c"
>                       - "marvell,mv78230-i2c"
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
> index 203a5482a866..2f817b0978a2 100644
> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> @@ -692,7 +692,7 @@ static const struct i2c_algorithm mv64xxx_i2c_algo = {
>   *****************************************************************************
>   */
>  static const struct of_device_id mv64xxx_i2c_of_match_table[] = {
> -	{ .compatible = "allwinner,sun4i-i2c", .data = &mv64xxx_i2c_regs_sun4i},
> +	{ .compatible = "allwinner,sun4i-a10-i2c", .data = &mv64xxx_i2c_regs_sun4i},
>  	{ .compatible = "allwinner,sun6i-a31-i2c", .data = &mv64xxx_i2c_regs_sun4i},
>  	{ .compatible = "marvell,mv64xxx-i2c", .data = &mv64xxx_i2c_regs_mv64xxx},
>  	{ .compatible = "marvell,mv78230-i2c", .data = &mv64xxx_i2c_regs_mv64xxx},
> -- 
> 1.9.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
