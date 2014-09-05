From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 5 Sep 2014 08:57:11 +0800
Subject: [PATCH 5/6] ARM: dts: imx28-tx28: Fix display duplicate name
 warning
In-Reply-To: <1409851379-5330-5-git-send-email-fabio.estevam@freescale.com>
References: <1409851379-5330-1-git-send-email-fabio.estevam@freescale.com>
 <1409851379-5330-5-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20140905005710.GG10809@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 04, 2014 at 02:22:58PM -0300, Fabio Estevam wrote:
> The lcdif node has a property named "display" and also a child node
> called "display", which causes the following warning:
> 
> device-tree: Duplicate name in lcdif at 80030000, renamed to "display#1"
> 
> Rename the child node name in order to avoid the warning.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx28-tx28.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
> index e14bd86..4af3750 100644
> --- a/arch/arm/boot/dts/imx28-tx28.dts
> +++ b/arch/arm/boot/dts/imx28-tx28.dts
> @@ -309,10 +309,10 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&lcdif_24bit_pins_a &lcdif_sync_pins_a &tx28_lcdif_ctrl_pins>;
>  	lcd-supply = <&reg_lcd>;
> -	display = <&display>;
> +	display = <&display0>;
>  	status = "okay";
>  
> -	display: display at 0 {
> +	display0: display0 {

  DTC     arch/arm/boot/dts/imx28-tx28.dtb
ERROR (path_references): Reference to non-existent node or label "display"

Shawn

>  		bits-per-pixel = <32>;
>  		bus-width = <24>;
>  		display-timings {
> -- 
> 1.9.1
> 
