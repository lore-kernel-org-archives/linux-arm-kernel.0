From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 9 Feb 2016 13:17:13 +0100
Subject: [PATCH] ARM: dts: zynq: Enable USB and USB PHY for ZYBO
In-Reply-To: <1454503265-20605-1-git-send-email-nathan@nathanrossi.com>
References: <1454503265-20605-1-git-send-email-nathan@nathanrossi.com>
Message-ID: <56B9D8C9.7060000@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3.2.2016 13:41, Nathan Rossi wrote:
> Setup the USB controller and configure it to operate in host mode.
> Additionally add the USB phy node for the ZYBO, including reset gpio
> which is connected to a external MIO pin.
> 
> Signed-off-by: Nathan Rossi <nathan@nathanrossi.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: S?ren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  arch/arm/boot/dts/zynq-zybo.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/zynq-zybo.dts b/arch/arm/boot/dts/zynq-zybo.dts
> index 16c9cac..8f085b3 100644
> --- a/arch/arm/boot/dts/zynq-zybo.dts
> +++ b/arch/arm/boot/dts/zynq-zybo.dts
> @@ -33,6 +33,11 @@
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	usb_phy0: phy0 {
> +		#phy-cells = <0>;
> +		compatible = "usb-nop-xceiv";
> +		reset-gpios = <&gpio0 46 1>;
> +	};
>  };
>  
>  &clkc {
> @@ -56,3 +61,9 @@
>  &uart1 {
>  	status = "okay";
>  };
> +
> +&usb0 {
> +	status = "okay";
> +	dr_mode = "host";
> +	usb-phy = <&usb_phy0>;
> +};
> 


Applied.

Thanks,
Michal
