From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 30 Jul 2012 09:27:46 +0800
Subject: [PATCH v3 2/3] ARM: dts: imx6q-sabrelite: add usbmisc device
In-Reply-To: <1343298916-11101-3-git-send-email-richard.zhao@freescale.com>
References: <1343298916-11101-1-git-send-email-richard.zhao@freescale.com>
 <1343298916-11101-3-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120730012744.GC30774@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch is doing a little bit more than what patch subject says.
Please either come up with a better subject and commit message or
split the patch to have it match the subject.

On Thu, Jul 26, 2012 at 06:35:15PM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> ---
>  arch/arm/boot/dts/imx6q-sabrelite.dts |    1 +
>  arch/arm/boot/dts/imx6q.dtsi          |   18 ++++++++++++++----
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> index d42e851..b32ebfc 100644
> --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> @@ -62,6 +62,7 @@
>  		aips-bus at 02100000 { /* AIPS2 */
>  			usb at 02184000 { /* USB OTG */
>  				vbus-supply = <&reg_usb_otg_vbus>;
> +				disable-over-current;
>  				status = "okay";
>  			};
>  
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index c25d495..41d16cc 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -19,6 +19,11 @@
>  		serial2 = &uart3;
>  		serial3 = &uart4;
>  		serial4 = &uart5;
> +
> +		usb0 = &usbotg;
> +		usb1 = &usbhost1;
> +		usb2 = &usbhost2;
> +		usb3 = &usbhost3;
>  	};
>  
>  	cpus {
> @@ -624,7 +629,7 @@
>  				reg = <0x0217c000 0x4000>;
>  			};
>  
> -			usb at 02184000 { /* USB OTG */
> +			usbotg: usb at 02184000 {

I basically would like to have the first line of every node exactly
match between <soc>.dtsi and <board>.dts.  Please also update the node
in imx6q-sabrelite.dtsi.

Regards,
Shawn

>  				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
>  				reg = <0x02184000 0x200>;
>  				interrupts = <0 43 0x04>;
> @@ -632,7 +637,7 @@
>  				status = "disabled";
>  			};
>  
> -			usb at 02184200 { /* USB1 */
> +			usbhost1: usb at 02184200 {
>  				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
>  				reg = <0x02184200 0x200>;
>  				interrupts = <0 40 0x04>;
> @@ -640,20 +645,25 @@
>  				status = "disabled";
>  			};
>  
> -			usb at 02184400 { /* USB2 */
> +			usbhost2: usb at 02184400 {
>  				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
>  				reg = <0x02184400 0x200>;
>  				interrupts = <0 41 0x04>;
>  				status = "disabled";
>  			};
>  
> -			usb at 02184600 { /* USB3 */
> +			usbhost3: usb at 02184600 {
>  				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
>  				reg = <0x02184600 0x200>;
>  				interrupts = <0 42 0x04>;
>  				status = "disabled";
>  			};
>  
> +			usbmisc at 02184800 {
> +				compatible = "fsl,imx6q-usbmisc";
> +				reg = <0x02184800 0x200>;
> +			};
> +
>  			ethernet at 02188000 {
>  				compatible = "fsl,imx6q-fec";
>  				reg = <0x02188000 0x4000>;
> -- 
> 1.7.9.5
> 
> 
