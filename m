From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 4 Dec 2017 12:10:19 +0100
Subject: [PATCH 04/12] ARM: dts: imx53-tx53-x03x: Move display node out
 of 'soc'
In-Reply-To: <1512156285-18451-4-git-send-email-festevam@gmail.com>
References: <1512156285-18451-1-git-send-email-festevam@gmail.com>
 <1512156285-18451-4-git-send-email-festevam@gmail.com>
Message-ID: <20171204121019.486b4160@karo-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri,  1 Dec 2017 17:24:37 -0200 Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Move disp0 node from soc node to root node.
> 
> disp0 node does not have any register properties and thus
> shouldn't be placed on the bus.
> 
> This fixes the following build warnings with W=1:
> 
> arch/arm/boot/dts/imx53-tx53-x03x.dtb: Warning (simple_bus_reg): Node /soc/disp0 missing or empty reg/ranges property
> 
> Cc: Lothar Wa?mann <LW@KARO-electronics.de>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/boot/dts/imx53-tx53-x03x.dts | 232 +++++++++++++++++-----------------
>  1 file changed, 115 insertions(+), 117 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx53-tx53-x03x.dts b/arch/arm/boot/dts/imx53-tx53-x03x.dts
> index 7eb53e4..fe15c95 100644
> --- a/arch/arm/boot/dts/imx53-tx53-x03x.dts
> +++ b/arch/arm/boot/dts/imx53-tx53-x03x.dts
> @@ -53,132 +53,130 @@
>  		display = &display;
>  	};
>  
> -	soc {
> -		display: disp0 {
> -			compatible = "fsl,imx-parallel-display";
> -			interface-pix-fmt = "rgb24";
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&pinctrl_rgb24_vga1>;
> -			status = "okay";
> +	display: disp0 {
> +		compatible = "fsl,imx-parallel-display";
> +		interface-pix-fmt = "rgb24";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_rgb24_vga1>;
> +		status = "okay";
>  
> -			port {
> -				display0_in: endpoint {
> -					remote-endpoint = <&ipu_di0_disp0>;
> -				};
> +		port {
> +			display0_in: endpoint {
> +				remote-endpoint = <&ipu_di0_disp0>;
>  			};
> +		};
>  
> -			display-timings {
> -				VGA {
> -					clock-frequency = <25200000>;
> -					hactive = <640>;
> -					vactive = <480>;
> -					hback-porch = <48>;
> -					hsync-len = <96>;
> -					hfront-porch = <16>;
> -					vback-porch = <31>;
> -					vsync-len = <2>;
> -					vfront-porch = <12>;
> -					hsync-active = <0>;
> -					vsync-active = <0>;
> -					de-active = <1>;
> -					pixelclk-active = <0>;
> -				};
> +		display-timings {
> +			VGA {
> +				clock-frequency = <25200000>;
> +				hactive = <640>;
> +				vactive = <480>;
> +				hback-porch = <48>;
> +				hsync-len = <96>;
> +				hfront-porch = <16>;
> +				vback-porch = <31>;
> +				vsync-len = <2>;
> +				vfront-porch = <12>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
>  
> -				ETV570 {
> -					clock-frequency = <25200000>;
> -					hactive = <640>;
> -					vactive = <480>;
> -					hback-porch = <114>;
> -					hsync-len = <30>;
> -					hfront-porch = <16>;
> -					vback-porch = <32>;
> -					vsync-len = <3>;
> -					vfront-porch = <10>;
> -					hsync-active = <0>;
> -					vsync-active = <0>;
> -					de-active = <1>;
> -					pixelclk-active = <0>;
> -				};
> +			ETV570 {
> +				clock-frequency = <25200000>;
> +				hactive = <640>;
> +				vactive = <480>;
> +				hback-porch = <114>;
> +				hsync-len = <30>;
> +				hfront-porch = <16>;
> +				vback-porch = <32>;
> +				vsync-len = <3>;
> +				vfront-porch = <10>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
>  
> -				ET0350 {
> -					clock-frequency = <6413760>;
> -					hactive = <320>;
> -					vactive = <240>;
> -					hback-porch = <34>;
> -					hsync-len = <34>;
> -					hfront-porch = <20>;
> -					vback-porch = <15>;
> -					vsync-len = <3>;
> -					vfront-porch = <4>;
> -					hsync-active = <0>;
> -					vsync-active = <0>;
> -					de-active = <1>;
> -					pixelclk-active = <0>;
> -				};
> +			ET0350 {
> +				clock-frequency = <6413760>;
> +				hactive = <320>;
> +				vactive = <240>;
> +				hback-porch = <34>;
> +				hsync-len = <34>;
> +				hfront-porch = <20>;
> +				vback-porch = <15>;
> +				vsync-len = <3>;
> +				vfront-porch = <4>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
>  
> -				ET0430 {
> -					clock-frequency = <9009000>;
> -					hactive = <480>;
> -					vactive = <272>;
> -					hback-porch = <2>;
> -					hsync-len = <41>;
> -					hfront-porch = <2>;
> -					vback-porch = <2>;
> -					vsync-len = <10>;
> -					vfront-porch = <2>;
> -					hsync-active = <0>;
> -					vsync-active = <0>;
> -					de-active = <1>;
> -					pixelclk-active = <1>;
> -				};
> +			ET0430 {
> +				clock-frequency = <9009000>;
> +				hactive = <480>;
> +				vactive = <272>;
> +				hback-porch = <2>;
> +				hsync-len = <41>;
> +				hfront-porch = <2>;
> +				vback-porch = <2>;
> +				vsync-len = <10>;
> +				vfront-porch = <2>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <1>;
> +			};
>  
> -				ET0500 {
> -					clock-frequency = <33264000>;
> -					hactive = <800>;
> -					vactive = <480>;
> -					hback-porch = <88>;
> -					hsync-len = <128>;
> -					hfront-porch = <40>;
> -					vback-porch = <33>;
> -					vsync-len = <2>;
> -					vfront-porch = <10>;
> -					hsync-active = <0>;
> -					vsync-active = <0>;
> -					de-active = <1>;
> -					pixelclk-active = <0>;
> -				};
> +			ET0500 {
> +				clock-frequency = <33264000>;
> +				hactive = <800>;
> +				vactive = <480>;
> +				hback-porch = <88>;
> +				hsync-len = <128>;
> +				hfront-porch = <40>;
> +				vback-porch = <33>;
> +				vsync-len = <2>;
> +				vfront-porch = <10>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
>  
> -				ET0700 { /* same as ET0500 */
> -					clock-frequency = <33264000>;
> -					hactive = <800>;
> -					vactive = <480>;
> -					hback-porch = <88>;
> -					hsync-len = <128>;
> -					hfront-porch = <40>;
> -					vback-porch = <33>;
> -					vsync-len = <2>;
> -					vfront-porch = <10>;
> -					hsync-active = <0>;
> -					vsync-active = <0>;
> -					de-active = <1>;
> -					pixelclk-active = <0>;
> -				};
> +			ET0700 { /* same as ET0500 */
> +				clock-frequency = <33264000>;
> +				hactive = <800>;
> +				vactive = <480>;
> +				hback-porch = <88>;
> +				hsync-len = <128>;
> +				hfront-porch = <40>;
> +				vback-porch = <33>;
> +				vsync-len = <2>;
> +				vfront-porch = <10>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
>  
> -				ETQ570 {
> -					clock-frequency = <6596040>;
> -					hactive = <320>;
> -					vactive = <240>;
> -					hback-porch = <38>;
> -					hsync-len = <30>;
> -					hfront-porch = <30>;
> -					vback-porch = <16>;
> -					vsync-len = <3>;
> -					vfront-porch = <4>;
> -					hsync-active = <0>;
> -					vsync-active = <0>;
> -					de-active = <1>;
> -					pixelclk-active = <0>;
> -				};
> +			ETQ570 {
> +				clock-frequency = <6596040>;
> +				hactive = <320>;
> +				vactive = <240>;
> +				hback-porch = <38>;
> +				hsync-len = <30>;
> +				hfront-porch = <30>;
> +				vback-porch = <16>;
> +				vsync-len = <3>;
> +				vfront-porch = <4>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
>  			};
>  		};
>  	};
Acked-by: Lothar Wa?mann <LW@KARO-electronics.de>


Lothar Wa?mann
