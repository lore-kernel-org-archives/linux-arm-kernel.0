From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 11 Jul 2012 12:14:33 +0800
Subject: [PATCH 4/6] ARM: apx4devkit: add SSP2 support
In-Reply-To: <1341904092-13777-5-git-send-email-lauri.hintsala@bluegiga.com>
References: <1341904092-13777-1-git-send-email-lauri.hintsala@bluegiga.com>
 <1341904092-13777-5-git-send-email-lauri.hintsala@bluegiga.com>
Message-ID: <20120711041431.GC14060@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2012 at 10:08:10AM +0300, Lauri Hintsala wrote:
> Signed-off-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>
> ---
>  arch/arm/boot/dts/apx4devkit.dts |   31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/apx4devkit.dts b/arch/arm/boot/dts/apx4devkit.dts
> index f6d1a57..9cf5ae6 100644
> --- a/arch/arm/boot/dts/apx4devkit.dts
> +++ b/arch/arm/boot/dts/apx4devkit.dts
> @@ -25,6 +25,14 @@
>  				status = "okay";
>  			};
>  
> +			ssp2: ssp at 80014000 {
> +				compatible = "fsl,imx28-mmc";
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&mmc2_4bit_pins_apx4 &mmc2_sck_cfg_apx4>;
> +				bus-width = <4>;
> +				status = "okay";
> +			};
> +
>  			pinctrl at 80018000 {
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&hog_pins_a>;
> @@ -52,6 +60,29 @@
>  					fsl,voltage = <1>;
>  					fsl,pull-up = <0>;
>  				};
> +
> +				mmc2_4bit_pins_apx4: mmc2-4bit-apx4 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <
> +						0x2041 /* MX28_PAD_SSP0_DATA4__SSP2_D0 */
> +						0x2051 /* MX28_PAD_SSP0_DATA5__SSP2_D3 */
> +						0x2061 /* MX28_PAD_SSP0_DATA6__SSP2_CMD */
> +						0x2071 /* MX28_PAD_SSP0_DATA7__SSP2_SCK */
> +						0x2141 /* MX28_PAD_SSP2_SS1__SSP2_D1 */
> +						0x2151 /* MX28_PAD_SSP2_SS2__SSP2_D2 */
> +					>;
> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};

Ideally, this should be defined in imx28.dtsi, since what pins can be
muxed on what functions is determined by soc design.  But I'm fine
with it for now, and we can move it later when there are other boards
using the same mux options emerging.

Regards,
Shawn

> +
> +				mmc2_sck_cfg_apx4: mmc2-sck-cfg-apx4 {
> +					fsl,pinmux-ids = <
> +						0x2071 /* MX28_PAD_SSP0_DATA7__SSP2_SCK */
> +					>;
> +					fsl,drive-strength = <2>;
> +					fsl,pull-up = <0>;
> +				};
>  			};
>  
>  			lcdif at 80030000 {
> -- 
> 1.7.9.5
> 
