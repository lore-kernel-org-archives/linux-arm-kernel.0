From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 17 Sep 2015 02:15:58 +0300
Subject: [PATCH 1/2] ARM: shmobile: r8a7794: add USB PHY DT support
In-Reply-To: <1590842.9hQm6l1zli@wasted.cogentembedded.com>
References: <1442100737.hcefR9HyDq@wasted.cogentembedded.com>
 <1590842.9hQm6l1zli@wasted.cogentembedded.com>
Message-ID: <55F9F82E.4000809@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 09/13/2015 01:50 AM, Sergei Shtylyov wrote:

> Define the R8A7794 generic part of the USB PHY device node. It is up to the
> board file to enable the device.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
>   arch/arm/boot/dts/r8a7794.dtsi |   19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
> +++ renesas/arch/arm/boot/dts/r8a7794.dtsi
> @@ -690,6 +690,25 @@
>   				 0x1000 0 0 2 &gic 0 113 IRQ_TYPE_LEVEL_HIGH>;
>   	};
>
> +	usbphy: usb-phy at e6590100 {
> +		compatible = "renesas,usb-phy-r8a7794";
> +		reg = <0 0xe6590100 0 0x100>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clocks = <&mstp7_clks R8A7794_CLK_HSUSB>;
> +		clock-names = "usbhs";

    Forgot to add "power-domains" prop here. :-(

MBR, Sergei
