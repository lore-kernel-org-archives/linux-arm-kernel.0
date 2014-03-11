From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 11 Mar 2014 23:13:15 +0300
Subject: [PATCH v2][ 6/8] ARM: dts: i.MX35: Add USB support.
In-Reply-To: <1394535304-10240-6-git-send-email-denis@eukrea.com>
References: <1394535304-10240-1-git-send-email-denis@eukrea.com>
 <1394535304-10240-6-git-send-email-denis@eukrea.com>
Message-ID: <531F6E5B.7070802@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03/11/2014 01:55 PM, Denis Carikli wrote:

> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> Changelog v1->v2:
> - The usbphy nodes were made to look like the ones in imx53.dtsi
> - The patch was rebased on top of the clock fixes commits.

> ---
>   arch/arm/boot/dts/imx35.dtsi |   16 ++++++++++++++++
>   1 file changed, 16 insertions(+)

> diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
> index 474a73d..b943123 100644
> --- a/arch/arm/boot/dts/imx35.dtsi
> +++ b/arch/arm/boot/dts/imx35.dtsi
> @@ -298,6 +298,7 @@
>   				interrupts = <37>;
>   				clocks = <&clks 73>;
>   				fsl,usbmisc = <&usbmisc 0>;
> +				fsl,usbphy = <&usbphy0>;

    Why use Freescale specific prop here, when there's de-facto standard 
"usb-phy" already?

> @@ -307,6 +308,7 @@
>   				interrupts = <35>;
>   				clocks = <&clks 73>;
>   				fsl,usbmisc = <&usbmisc 1>;
> +				fsl,usbphy = <&usbphy1>;

    Likewise.

> @@ -355,4 +357,18 @@
>   			};
>   		};
>   	};
> +
> +	usbphy {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "simple-bus";
> +
> +		usbphy0: usbphy at 0 {

    Why use the node name with the address part when you don't have "reg" prop?
Moreover, I suggest "usb-phy" instead to be more in line with ePAPR [1] 
specified "ethernet-phy" device nodes.

[1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

WBR, Sergei
