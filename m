From: horms@verge.net.au (Simon Horman)
Date: Fri, 30 May 2014 08:34:54 +0900
Subject: [PATCH 2/2] arm: shmobile: r8a7791: add USB3.0 node to
 r8a7791.dtsi
In-Reply-To: <5387149A.4010503@renesas.com>
References: <5387149A.4010503@renesas.com>
Message-ID: <20140529233453.GA15648@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 29, 2014 at 08:06:02PM +0900, Yoshihiro Shimoda wrote:
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  arch/arm/boot/dts/r8a7791.dtsi |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index c2b5b38..2855c1f 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -906,4 +906,14 @@
>  		#size-cells = <0>;
>  		status = "disabled";
>  	};
> +
> +	xhci: xhci at ee000000 {
> +		compatible = "renesas,xhci-r8a7791";
> +		reg = <0 0xee000000 0 0xc00>;
> +		interrupts = <0 101 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp3_clks R8A7791_CLK_SSUSB>;
> +		phys = <&usbphy 1 1>;
> +		phy-names = "usb";
> +		status = "disabled";
> +	};
>  };

I assume that Sergei's comments regarding the r8a7790 version
of this change are equally relevant here.
