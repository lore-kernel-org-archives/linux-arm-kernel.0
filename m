From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 4 Jul 2012 21:53:38 +0800
Subject: [PATCH] i.mx23: add dts node for mmc1/ssp1 Signed-off-by: Attila
 Kinali <attila@kinali.ch>
In-Reply-To: <1341403833-25437-1-git-send-email-attila@kinali.ch>
References: <1341403833-25437-1-git-send-email-attila@kinali.ch>
Message-ID: <20120704135337.GC2595@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suggested subject prefix "ARM: dts: imx23: ..."

On Wed, Jul 04, 2012 at 02:10:33PM +0200, Attila Kinali wrote:
> ---
>  arch/arm/boot/dts/imx23.dtsi |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
> index 8c5f999..df0ae8d 100644
> --- a/arch/arm/boot/dts/imx23.dtsi
> +++ b/arch/arm/boot/dts/imx23.dtsi
> @@ -134,6 +134,21 @@
>  					fsl,pinmux-ids = <0x2010 0x2060>;
>  					fsl,pull-up = <0>;
>  				};
> +
> +				mmc1_8bit_pins_a: mmc1-8bit at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <0x0002 0x0012 0x0022
> +						0x0032 0x0042 0x0052 0x0062
> +						0x0072 0x0142 0x0132 0x0182>;

Please take a look at the following branch to see how these should be
formated now.

http://git.linaro.org/gitweb?p=people/shawnguo/linux-2.6.git;a=shortlog;h=refs/heads/mxs/dt-for-3.6

> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};
> +
> +				mmc1_pins_fixup: mmc1-pins-fixup {
> +					fsl,pinmux-ids = <0x0132 0x0182>;
> +					fsl,pull-up = <0>;
> +				};

I do not want to have these pinctrl setup added along.  Please submit
the changes together with the <board>.dts which uses them.

Regards,
Shawn

>  			};
>  
>  			digctl at 8001c000 {
> -- 
> 1.7.10
> 
