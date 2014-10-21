From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 21 Oct 2014 07:54:20 +0200
Subject: [PATCH RFC v2 8/8] ARM: zynq: DT: Add pinctrl information
In-Reply-To: <1413479495-14206-9-git-send-email-soren.brinkmann@xilinx.com>
References: <1413479495-14206-1-git-send-email-soren.brinkmann@xilinx.com>
 <1413479495-14206-9-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <ab4a1ef9a5f24e9e804dc27f6f1cea36@BN1AFFO11FD007.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16/2014 07:11 PM, Soren Brinkmann wrote:
> Add pinctrl descriptions to the zc702 and zc706 device trees.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  arch/arm/boot/dts/zynq-7000.dtsi |   8 ++-
>  arch/arm/boot/dts/zynq-zc702.dts | 147 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/zynq-zc706.dts | 126 +++++++++++++++++++++++++++++++++
>  3 files changed, 280 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index 24036c440440..37d7fe36a129 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -238,7 +238,7 @@
>  		slcr: slcr at f8000000 {
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -			compatible = "xlnx,zynq-slcr", "syscon";
> +			compatible = "xlnx,zynq-slcr", "syscon", "simple-bus";

I expect that you have this here to be able to probe the driver.
slcr is not the bus.
You should be able just to probe child nodes.

Thanks,
Michal
