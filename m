From: horms@verge.net.au (Simon Horman)
Date: Wed, 4 Jun 2014 10:06:47 +0900
Subject: [PATCH v2 2/2] arm: shmobile: r8a7790: add USB3.0 node to
 r8a7790.dtsi
In-Reply-To: <538D7124.60709@renesas.com>
References: <538D7124.60709@renesas.com>
Message-ID: <20140604010646.GC25936@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 03, 2014 at 03:54:28PM +0900, Yoshihiro Shimoda wrote:
> This node depends on a generic phy driver of usb.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

I think it would be best if you resubmitted this patch once the
driver has been accepted. Likewise for the r8a7791 variant of this patch.

> ---
>  arch/arm/boot/dts/r8a7790.dtsi |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index e06c486..985c253 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -902,4 +902,14 @@
>  		#size-cells = <0>;
>  		status = "disabled";
>  	};
> +
> +	xhci: usb at ee000000 {
> +		compatible = "renesas,xhci-r8a7790";
> +		reg = <0 0xee000000 0 0xc00>;
> +		interrupts = <0 101 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp3_clks R8A7790_CLK_SSUSB>;
> +		phys = <&usbphy 1 1>;
> +		phy-names = "usb";
> +		status = "disabled";
> +	};
>  };
> -- 
> 1.7.9.5
> 
