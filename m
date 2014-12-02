From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 2 Dec 2014 10:40:28 +0100
Subject: [PATCH v2] ARM: zynq: DT: Add USB to device tree
In-Reply-To: <1417509978-19060-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1417509978-19060-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <63f1ea2ffb3f49f29ec46183f3009817@BN1AFFO11FD032.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2014 09:46 AM, Soren Brinkmann wrote:
> Add USB nodes to zc702, zc706 and zed device trees.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
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
> index ce2ef5bec4f2..68096bb027db 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -315,6 +315,26 @@
>  			clocks = <&clkc 4>;
>  		};
>  
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
> +
>  		watchdog0: watchdog at f8005000 {
>  			clocks = <&clkc 45>;
>  			compatible = "xlnx,zynq-wdt-r1p2";
> diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
> index 94e2cda6f9b6..f80c6e65f6e8 100644
> --- a/arch/arm/boot/dts/zynq-zc702.dts
> +++ b/arch/arm/boot/dts/zynq-zc702.dts
> @@ -36,6 +36,11 @@
>  			linux,default-trigger = "heartbeat";
>  		};
>  	};
> +
> +	usb_phy0: usb-phy {
> +		compatible = "usb-nop-xceiv";
> +		#phy-cells = <0>;
> +	};
>  };
>  
>  &can0 {
> @@ -135,3 +140,9 @@
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
> index a8bbdfbc7093..bece52e47cfe 100644
> --- a/arch/arm/boot/dts/zynq-zc706.dts
> +++ b/arch/arm/boot/dts/zynq-zc706.dts
> @@ -27,6 +27,10 @@
>  		bootargs = "console=ttyPS0,115200 earlyprintk";
>  	};
>  
> +	usb_phy0: usb-phy {
> +		compatible = "usb-nop-xceiv";
> +		#phy-cells = <0>;
> +	};
>  };
>  
>  &gem0 {
> @@ -114,3 +118,9 @@
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
> index 697779a353ed..efecb2379832 100644
> --- a/arch/arm/boot/dts/zynq-zed.dts
> +++ b/arch/arm/boot/dts/zynq-zed.dts
> @@ -27,6 +27,10 @@
>  		bootargs = "console=ttyPS0,115200 earlyprintk";
>  	};
>  
> +	usb_phy0: usb-phy {
> +		compatible = "usb-nop-xceiv";
> +		#phy-cells = <0>;
> +	};
>  };
>  
>  &gem0 {
> @@ -46,3 +50,9 @@
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

Based on Arnd comment please fix it and rebase it on the top of zynq/dt branch.

Thanks,
Michal
