From: rogerq@ti.com (Roger Quadros)
Date: Wed, 5 Aug 2015 11:01:22 +0300
Subject: [PATCH 09/10] ARM: dts: omap4: Use "syscon-phy-power" instead
 of "ctrl-module" in USB PHY node
In-Reply-To: <1438702233-8027-10-git-send-email-kishon@ti.com>
References: <1438702233-8027-1-git-send-email-kishon@ti.com>
 <1438702233-8027-10-git-send-email-kishon@ti.com>
Message-ID: <55C1C2D2.1080200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/15 18:30, Kishon Vijay Abraham I wrote:
> Add "syscon-phy-power" property and remove the deprecated "ctrl-module"
> property from USB PHY dt node.
> 
> Since "omap_control_usb2phy" devicetree node is no longer used,
> remove it.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger

> ---
>  arch/arm/boot/dts/omap4.dtsi |    8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 7d31c6f..b27634d 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -703,7 +703,7 @@
>  			usb2_phy: usb2phy at 4a0ad080 {
>  				compatible = "ti,omap-usb2";
>  				reg = <0x4a0ad080 0x58>;
> -				ctrl-module = <&omap_control_usb2phy>;
> +				syscon-phy-power = <&scm_conf 0x300>;
>  				clocks = <&usb_phy_cm_clk32k>;
>  				clock-names = "wkupclk";
>  				#phy-cells = <0>;
> @@ -854,12 +854,6 @@
>  			};
>  		};
>  
> -		omap_control_usb2phy: control-phy at 4a002300 {
> -			compatible = "ti,control-phy-usb2";
> -			reg = <0x4a002300 0x4>;
> -			reg-names = "power";
> -		};
> -
>  		omap_control_usbotg: control-phy at 4a00233c {
>  			compatible = "ti,control-phy-otghs";
>  			reg = <0x4a00233c 0x4>;
> 
