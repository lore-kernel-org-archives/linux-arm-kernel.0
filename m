From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 10 Apr 2014 10:15:10 +0200
Subject: [PATCH] ARM: dts: imx53-tx53: add IPU DI ports and endpoints
In-Reply-To: <1397114395-19587-1-git-send-email-shawn.guo@freescale.com>
References: <1397114395-19587-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20140410101510.4ee33e64@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo wrote:
> With the recent imx-drm device tree binding changes, we need to add IPU
> DI ports and endpoints for adapting.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/boot/dts/imx53-tx53-x03x.dts | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx53-tx53-x03x.dts b/arch/arm/boot/dts/imx53-tx53-x03x.dts
> index 0217dde3..3b73e81 100644
> --- a/arch/arm/boot/dts/imx53-tx53-x03x.dts
> +++ b/arch/arm/boot/dts/imx53-tx53-x03x.dts
> @@ -25,12 +25,17 @@
>  	soc {
>  		display: display at di0 {
>  			compatible = "fsl,imx-parallel-display";
> -			crtcs = <&ipu 0>;
>  			interface-pix-fmt = "rgb24";
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&pinctrl_rgb24_vga1>;
>  			status = "okay";
>  
> +			port {
> +				display0_in: endpoint {
> +					remote-endpoint = <&ipu_di0_disp0>;
> +				};
> +			};
> +
>  			display-timings {
>  				VGA {
>  					clock-frequency = <25200000>;
> @@ -293,6 +298,10 @@
>  	};
>  };
>  
> +&ipu_di0_disp0 {
> +	remote-endpoint = <&display0_in>;
> +};
> +
>  &kpp {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_kpp>;

Acked-by: Lothar Wa?mann <LW@KARO-electronics.de>

-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
