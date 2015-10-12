From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 12 Oct 2015 11:32:44 +0200
Subject: [PATCH 2/3] dts: Updated devicetree bindings for Zynq 7000
 platform
In-Reply-To: <1444344307-22509-3-git-send-email-moritz.fischer@ettus.com>
References: <1444344307-22509-1-git-send-email-moritz.fischer@ettus.com>
 <1444344307-22509-3-git-send-email-moritz.fischer@ettus.com>
Message-ID: <561B7E3C.4060908@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/2015 12:45 AM, Moritz Fischer wrote:
> Added addtional bindings required for FPGA Manager operation
> of the Xilinx Zynq Devc configuration interface.
> 
> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> ---
>  arch/arm/boot/dts/zynq-7000.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index dc0457e..1a5220e 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -294,6 +294,11 @@
>  		devcfg: devcfg at f8007000 {
>  			compatible = "xlnx,zynq-devcfg-1.0";
>  			reg = <0xf8007000 0x100>;
> +			interrupt-parent = <&intc>;
> +			interrupts = <0 8 4>;
> +			clocks = <&clkc 12>;
> +			clock-names = "ref_clk";
> +			syscon = <&slcr>;
>  		};
>  
>  		global_timer: timer at f8f00200 {
> 

This patch should go via arm-soc tree. That's why please remove it from
this patchset.

Thanks,
Michal
