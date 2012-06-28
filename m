From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Jun 2012 11:37:59 +0800
Subject: [PATCH 1/2] ARM: dts: imx28: Add additionnal muxing options to
 iMX28 DTSI
In-Reply-To: <1340785092-27035-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1340785092-27035-1-git-send-email-maxime.ripard@free-electrons.com>
 <1340785092-27035-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20120628033757.GA30041@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2012 at 10:18:11AM +0200, Maxime Ripard wrote:
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Cc: Brian Lily <brian@crystalfontz.com>
> ---
>  arch/arm/boot/dts/imx28.dtsi |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 4634cb8..2b067d2 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -167,6 +167,14 @@
>  					fsl,pull-up = <0>;
>  				};
>  
> +				duart_pins_b: duart at 1 {
> +					reg = <1>;
> +					fsl,pinmux-ids = <0x3022 0x3032>;
> +					fsl,drive-strength = <0>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <0>;
> +				};
> +

This should be put right after duart_pins_a.  I fixed it up and applied
the patch.

Regards,
Shawn

>  				mac0_pins_a: mac0 at 0 {
>  					reg = <0>;
>  					fsl,pinmux-ids = <0x4000 0x4010 0x4020
> @@ -196,6 +204,15 @@
>  					fsl,pull-up = <1>;
>  				};
>  
> +				mmc0_4bit_pins_a: mmc0-4bit at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <0x2000 0x2010 0x2020
> +						0x2030 0x2080 0x2090 0x20a0>;
> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};
> +
>  				mmc0_cd_cfg: mmc0-cd-cfg {
>  					fsl,pinmux-ids = <0x2090>;
>  					fsl,pull-up = <0>;
> -- 
> 1.7.9.5
> 
