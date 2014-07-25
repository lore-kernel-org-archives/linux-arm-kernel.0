From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 25 Jul 2014 08:00:17 -0700
Subject: [PATCH v2] ARM: zynq: DT: Add CAN node
In-Reply-To: <56bf20294d106e0fc9c23a70cd991a50b441d0aa.1406271138.git.michal.simek@xilinx.com>
References: <56bf20294d106e0fc9c23a70cd991a50b441d0aa.1406271138.git.michal.simek@xilinx.com>
Message-ID: <bed4104c-c177-4c6d-bffe-3535b9c0d354@BN1AFFO11FD029.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-07-25 at 08:52AM +0200, Michal Simek wrote:
> Add node describing Zynq's CAN controller.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - Add can1
> - Enable can0 for zc702
> - Use status property
> 
>  arch/arm/boot/dts/zynq-7000.dtsi | 26 +++++++++++++++++++++++++-
>  arch/arm/boot/dts/zynq-zc702.dts |  4 ++++
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index 366ca6434f54..983148111e3a 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -71,7 +71,31 @@
>  			interrupts = <0 7 4>;
>  			interrupt-parent = <&intc>;
>  			clocks = <&clkc 12>;
> -		};
> +		};
> +
> +		can0: can at e0008000 {
> +			compatible = "xlnx,zynq-can-1.0";
> +			status = "disabled";
> +			clocks = <&clkc 19>, <&clkc 36>;
> +			clock-names = "can_clk", "pclk";
> +			reg = <0xe0008000 0x1000>;
> +			interrupts = <0 28 4>;
> +			interrupt-parent = <&intc>;
> +			tx-fifo-depth = <0x40>;
> +			rx-fifo-depth = <0x40>;
> +		};
> +
> +		can1: can at e0009000 {
> +			compatible = "xlnx,zynq-can-1.0";
> +			status = "disabled";
> +			clocks = <&clkc 19>, <&clkc 36>;
The clocks for CAN1 must be outputs 20 and 37 of the clkc.

	S?ren
