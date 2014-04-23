From: monstr@monstr.eu (Michal Simek)
Date: Wed, 23 Apr 2014 08:29:24 +0200
Subject: [RESEND PATCH v3 9/9] ARM: zynq: DT: Migrate UART to Cadence
 binding
In-Reply-To: <1396657425-31029-9-git-send-email-soren.brinkmann@xilinx.com>
References: <1396657425-31029-1-git-send-email-soren.brinkmann@xilinx.com>
 <1396657425-31029-9-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <53575DC4.6080008@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/2014 02:23 AM, Soren Brinkmann wrote:
> The Zynq UART is Cadence IP and the driver has been renamed accordingly.
> Migrate the DT to use the new binding for the UART driver.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> Acked-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Tested-by: Michal Simek <michal.simek@xilinx.com>
> ---
> This change depends on 'tty: xuartps: Rebrand driver as Cadence UART',
> which introduces the new clock-names.
> 
> Changes in v3: None
> Changes in v2: None
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  arch/arm/boot/dts/zynq-7000.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index 789d0bacc110..d27eb5c21831 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -73,19 +73,19 @@
>  		};
>  
>  		uart0: uart at e0000000 {
> -			compatible = "xlnx,xuartps";
> +			compatible = "xlnx,xuartps", "cdns,uart-r1p8";
>  			status = "disabled";
>  			clocks = <&clkc 23>, <&clkc 40>;
> -			clock-names = "ref_clk", "aper_clk";
> +			clock-names = "uart_clk", "pclk";
>  			reg = <0xE0000000 0x1000>;
>  			interrupts = <0 27 4>;
>  		};
>  
>  		uart1: uart at e0001000 {
> -			compatible = "xlnx,xuartps";
> +			compatible = "xlnx,xuartps", "cdns,uart-r1p8";
>  			status = "disabled";
>  			clocks = <&clkc 24>, <&clkc 41>;
> -			clock-names = "ref_clk", "aper_clk";
> +			clock-names = "uart_clk", "pclk";
>  			reg = <0xE0001000 0x1000>;
>  			interrupts = <0 50 4>;
>  		};
> 

Applied to zynq/dt2 branch.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140423/ff0f6fd8/attachment.sig>
