From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 8 Jun 2015 09:27:25 +0200
Subject: [PATCH v2 2/2] arm64: dts: mt8173: Add I2C device node
In-Reply-To: <1433164107-26568-3-git-send-email-eddie.huang@mediatek.com>
References: <1433164107-26568-1-git-send-email-eddie.huang@mediatek.com>
 <1433164107-26568-3-git-send-email-eddie.huang@mediatek.com>
Message-ID: <20150608072725.GJ6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eddie,

On Mon, Jun 01, 2015 at 09:08:27PM +0800, Eddie Huang wrote:
> Add MT8173 I2C device nodes, include I2C controllers and pins.
> MT8173 has six I2C controllers, from i2c0 to i2c6, exclude i2c5.
> The 6th I2C controller register base doesn't next to 5th I2C,
> and there is a hardware between 5th and 6th I2C controller. So
> SoC designer name 6th controller as "i2c6", not "i2c5".
> 
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 119 +++++++++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index b52ec43..7003ed2 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -158,6 +158,53 @@
>  			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
>  						<GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
>  						<GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
> +			i2c0_pins_a: i2c0 at 0 {
> +				pins1 {
> +					pinmux = <MT8173_PIN_45_SDA0__FUNC_SDA0>,
> +						 <MT8173_PIN_46_SCL0__FUNC_SCL0>;
> +					bias-disable;
> +				};
> +			};

The pinmux nodes should be in the board dts, not in the SoC dtsi.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
