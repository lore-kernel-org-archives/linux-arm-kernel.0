From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 14 Dec 2015 16:46:14 +0000
Subject: [PATCH] ARM64: ZynqMP: DT: Fix GIC's 'reg' property
In-Reply-To: <1450110700-14152-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1450110700-14152-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <20151214164613.GH21356@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 08:31:40AM -0800, Soren Brinkmann wrote:
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 857eda5c7217..b5d1facadf16 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -80,10 +80,10 @@
>  		gic: interrupt-controller at f9010000 {
>  			compatible = "arm,gic-400", "arm,cortex-a15-gic";
>  			#interrupt-cells = <3>;
> -			reg = <0x0 0xf9010000 0x10000>,
> -			      <0x0 0xf902f000 0x2000>,
> +			reg = <0x0 0xf9010000 0x1000>,
> +			      <0x0 0xf9020000 0x20000>,
>  			      <0x0 0xf9040000 0x20000>,
> -			      <0x0 0xf906f000 0x2000>;
> +			      <0x0 0xf9060000 0x20000>;

I'm confused. These sizes don't look right for GIC-400. Is this a custom
GIC?

Did this ever work wit hteh old offsets and sizes?

Mark.
