From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 24 Jan 2016 18:30:51 +0100
Subject: [PATCH 1/2] ARM: DTS: kirkwood-openrd: fix pin names for UART/SD
 selection
In-Reply-To: <1452629253-21748-1-git-send-email-aaro.koskinen@iki.fi>
References: <1452629253-21748-1-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <20160124173051.GT3880@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2016 at 10:07:32PM +0200, Aaro Koskinen wrote:
> The UART/SD pin names are swapped, fix that.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

This, and 2/2:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks
	Andrew

> ---
>  arch/arm/boot/dts/kirkwood-openrd.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-openrd.dtsi b/arch/arm/boot/dts/kirkwood-openrd.dtsi
> index d3330da..2a3dafd 100644
> --- a/arch/arm/boot/dts/kirkwood-openrd.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-openrd.dtsi
> @@ -40,7 +40,7 @@
>  			pinctrl-0 = <&pmx_select28 &pmx_sdio_cd &pmx_select34>;
>  			pinctrl-names = "default";
>  
> -			pmx_select28: pmx-select-uart-sd {
> +			pmx_select28: pmx-select-rs232-rs484 {
>  				marvell,pins = "mpp28";
>  				marvell,function = "gpio";
>  			};
> @@ -48,7 +48,7 @@
>  				marvell,pins = "mpp29";
>  				marvell,function = "gpio";
>  			};
> -			pmx_select34: pmx-select-rs232-rs484 {
> +			pmx_select34: pmx-select-uart-sd {
>  				marvell,pins = "mpp34";
>  				marvell,function = "gpio";
>  			};
> -- 
> 2.4.0
> 
