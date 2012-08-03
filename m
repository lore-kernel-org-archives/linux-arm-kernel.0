From: balbi@ti.com (Felipe Balbi)
Date: Fri, 3 Aug 2012 16:32:54 +0300
Subject: [PATCH v6 08/11] arm/dts: Add twl4030-usb data
In-Reply-To: <1343639400-28725-9-git-send-email-kishon@ti.com>
References: <1343639400-28725-1-git-send-email-kishon@ti.com>
 <1343639400-28725-9-git-send-email-kishon@ti.com>
Message-ID: <20120803133253.GJ8269@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 30, 2012 at 02:39:57PM +0530, Kishon Vijay Abraham I wrote:
> Add twl4030-usb data node in twl4030 device tree file.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/boot/dts/twl4030.dtsi |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
> index 22f4d13..761a5a5 100644
> --- a/arch/arm/boot/dts/twl4030.dtsi
> +++ b/arch/arm/boot/dts/twl4030.dtsi
> @@ -37,6 +37,18 @@
>  		regulator-max-microvolt = <3150000>;
>  	};
>  
> +	vusb1v5: regulator-vusb1v5 {
> +		compatible = "ti,twl4030-vusb1v5";
> +	};
> +
> +	vusb1v8: regulator-vusb1v8 {
> +		compatible = "ti,twl4030-vusb1v8";
> +	};
> +
> +	vusb3v1: regulator-vusb3v1 {
> +		compatible = "ti,twl4030-vusb3v1";
> +	};
> +
>  	twl_gpio: gpio {
>  		compatible = "ti,twl4030-gpio";
>  		gpio-controller;
> @@ -44,4 +56,13 @@
>  		interrupt-controller;
>  		#interrupt-cells = <1>;
>  	};
> +
> +	twl4030-usb {
> +		compatible = "ti,twl4030-usb";
> +		interrupts = < 10 4 >;
> +		usb1v5-supply = <&vusb1v5>;
> +		usb1v8-supply = <&vusb1v8>;
> +		usb3v1-supply = <&vusb3v1>;
> +		usb_mode = <1>;
> +	};
>  };
> -- 
> 1.7.9.5
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120803/76a64375/attachment.sig>
