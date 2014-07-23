From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 23 Jul 2014 09:07:02 -0700
Subject: [PATCH] ARM: zynq: DT: Add CAN node
In-Reply-To: <52d799e17cd3539713625c6f6a6666620f52d692.1406120732.git.michal.simek@xilinx.com>
References: <52d799e17cd3539713625c6f6a6666620f52d692.1406120732.git.michal.simek@xilinx.com>
Message-ID: <0a68731a-e0f0-4e19-b9a4-57cec4c8de3b@BN1BFFO11FD048.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-07-23 at 03:05PM +0200, Michal Simek wrote:
> Add node describing Zynq's CAN controller.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  arch/arm/boot/dts/zynq-7000.dtsi | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index 366ca6434f54..2287d9b4ed1a 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -71,7 +71,18 @@
>  			interrupts = <0 7 4>;
>  			interrupt-parent = <&intc>;
>  			clocks = <&clkc 12>;
> -		};
> +		};
> +
> +		can0: can at e0008000 {
> +			compatible = "xlnx,zynq-can-1.0";
> +			clocks = <&clkc 19>, <&clkc 36>;
> +			clock-names = "can_clk", "pclk";
> +			reg = <0xe0008000 0x1000>;
> +			interrupts = <0 28 4>;
> +			interrupt-parent = <&intc>;
> +			tx-fifo-depth = <0x40>;
> +			rx-fifo-depth = <0x40>;
> +		};

What about the second CAN core? You also probably want to add
'status = "disabled"' in the dtsi.

	S?ren
