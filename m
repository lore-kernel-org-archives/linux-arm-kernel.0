From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 3 Dec 2014 09:39:45 +0100
Subject: [PATCH v3] ARM: zynq: DT: Add USB to device tree
In-Reply-To: <1417536431-27759-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1417536431-27759-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <d78fedd84f354d80985187f851cb3cd1@BN1AFFO11FD055.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2014 05:07 PM, Soren Brinkmann wrote:
> Add USB nodes to zc702, zc706 and zed device trees.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> v3:
>  - rename phy nodes: usb_phy -> phy0
>  - rebased onto zynq/dt
> v2:
>  - remove '@0' from phy node name
>  - don't add bogus space
> ---
>  arch/arm/boot/dts/zynq-7000.dtsi | 20 ++++++++++++++++++++
>  arch/arm/boot/dts/zynq-zc702.dts | 11 +++++++++++
>  arch/arm/boot/dts/zynq-zc706.dts | 10 ++++++++++
>  arch/arm/boot/dts/zynq-zed.dts   | 10 ++++++++++
>  4 files changed, 51 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index f8e4a28adfc0..21aae01a3fe9 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -314,5 +314,25 @@
>  			reg = <0xf8f00600 0x20>;
>  			clocks = <&clkc 4>;
>  		};
> +
> +		usb0: usb at e0002000 {
> +			compatible = "xlnx,zynq-usb-2.20a", "chipidea,usb2";
> +			status = "disabled";
> +			clocks = <&clkc 28>;
> +			interrupt-parent = <&intc>;
> +			interrupts = <0 21 4>;
> +			reg = <0xe0002000 0x1000>;
> +			phy_type = "ulpi";
> +		};
> +
> +		usb1: usb at e0003000 {
> +			compatible = "xlnx,zynq-usb-2.20a", "chipidea,usb2";
> +			status = "disabled";
> +			clocks = <&clkc 29>;
> +			interrupt-parent = <&intc>;
> +			interrupts = <0 44 4>;
> +			reg = <0xe0003000 0x1000>;
> +			phy_type = "ulpi";
> +		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
> index 280f02dd4ddc..399fed4d9c19 100644
> --- a/arch/arm/boot/dts/zynq-zc702.dts
> +++ b/arch/arm/boot/dts/zynq-zc702.dts
> @@ -36,6 +36,11 @@
>  			linux,default-trigger = "heartbeat";
>  		};
>  	};
> +
> +	usb_phy0: phy0 {
> +		compatible = "usb-nop-xceiv";
> +		#phy-cells = <0>;
> +	};
>  };
>  
>  &can0 {
> @@ -139,3 +144,9 @@
>  &uart1 {
>  	status = "okay";
>  };
> +
> +&usb0 {
> +	status = "okay";
> +	dr_mode = "host";
> +	usb-phy = <&usb_phy0>;
> +};
> diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
> index 34f7812d2ee8..89cc9adc569d 100644
> --- a/arch/arm/boot/dts/zynq-zc706.dts
> +++ b/arch/arm/boot/dts/zynq-zc706.dts
> @@ -27,6 +27,10 @@
>  		bootargs = "console=ttyPS0,115200 earlyprintk";
>  	};
>  
> +	usb_phy0: phy0 {
> +		compatible = "usb-nop-xceiv";
> +		#phy-cells = <0>;
> +	};
>  };
>  
>  &clkc {
> @@ -118,3 +122,9 @@
>  &uart1 {
>  	status = "okay";
>  };
> +
> +&usb0 {
> +	status = "okay";
> +	dr_mode = "host";
> +	usb-phy = <&usb_phy0>;
> +};
> diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zed.dts
> index 1c7cc990b47a..e20956e5e720 100644
> --- a/arch/arm/boot/dts/zynq-zed.dts
> +++ b/arch/arm/boot/dts/zynq-zed.dts
> @@ -27,6 +27,10 @@
>  		bootargs = "console=ttyPS0,115200 earlyprintk";
>  	};
>  
> +	usb_phy0: phy0 {
> +		compatible = "usb-nop-xceiv";
> +		#phy-cells = <0>;
> +	};
>  };
>  
>  &clkc {
> @@ -50,3 +54,9 @@
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

Applied to zynq/dt.

Thanks,
Michal
