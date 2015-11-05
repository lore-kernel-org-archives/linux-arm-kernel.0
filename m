From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 5 Nov 2015 13:10:54 +0100
Subject: [PATCH] ARM: dts: zynq: describe SLCR as simple-mfd rather than
 simple-bus
In-Reply-To: <1446713167-29306-1-git-send-email-yamada.masahiro@socionext.com>
References: <1446713167-29306-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <563B474E.2000106@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2015 09:46 AM, Masahiro Yamada wrote:
> The SLCR (System-Level Control Registers) block is an MFD (Multi
> Function Device) rather than a bus.
> 
> "simple-mfd" seems a more suitable compatible string than "simple-bus".
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/arm/boot/dts/zynq-7000.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index 1a5220e..64ddd4d 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -238,7 +238,7 @@
>  		slcr: slcr at f8000000 {
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -			compatible = "xlnx,zynq-slcr", "syscon", "simple-bus";
> +			compatible = "xlnx,zynq-slcr", "syscon", "simple-mfd";
>  			reg = <0xF8000000 0x1000>;
>  			ranges;
>  			clkc: clkc at 100 {
> 

Applied.

Thanks,
Michal
