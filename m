From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 01 Aug 2018 21:11:05 +0800
Subject: [PATCH v3 02/14] ARM: dts: sunxi: h3/h5: Fix i2c2 register address
In-Reply-To: <20170926072234.27481-3-clabbe.montjoie@gmail.com>
References: <20170926072234.27481-1-clabbe.montjoie@gmail.com>
 <20170926072234.27481-3-clabbe.montjoie@gmail.com>
Message-ID: <1c12672d56b1e97aa594d2938ea9a36b5c0a98e0.camel@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-09-26?? 09:22 +0200?Corentin Labbe???
> The unit address and register address does not match.
> This patch fix the register address with the good one.
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

This patch should be backported.

Older LTS also needs patches, but the patch needs to be refactored to
suite the versions.

Cc: stable at vger.kernel.org # 4.14

> ---
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> index b37ed3461229..289f2cd06dfe 100644
> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> @@ -632,7 +632,7 @@
>  
>  		i2c2: i2c at 1c2b400 {
>  			compatible = "allwinner,sun6i-a31-i2c";
> -			reg = <0x01c2b000 0x400>;
> +			reg = <0x01c2b400 0x400>;
>  			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&ccu CLK_BUS_I2C2>;
>  			resets = <&ccu RST_BUS_I2C2>;
