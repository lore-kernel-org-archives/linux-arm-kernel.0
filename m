From: monstr@monstr.eu (Michal Simek)
Date: Wed, 23 Apr 2014 08:29:14 +0200
Subject: [RESEND PATCH v3 8/9] tty: cadence: Document DT binding
In-Reply-To: <1396657425-31029-8-git-send-email-soren.brinkmann@xilinx.com>
References: <1396657425-31029-1-git-send-email-soren.brinkmann@xilinx.com>
 <1396657425-31029-8-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <53575DBA.9070704@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/2014 02:23 AM, Soren Brinkmann wrote:
> Add binding documentation for the Cadence UART.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> Acked-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Tested-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  .../devicetree/bindings/serial/cdns,uart.txt         | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/cdns,uart.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.txt b/Documentation/devicetree/bindings/serial/cdns,uart.txt
> new file mode 100644
> index 000000000000..a3eb154c32ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/cdns,uart.txt
> @@ -0,0 +1,20 @@
> +Binding for Cadence UART Controller
> +
> +Required properties:
> +- compatible : should be "cdns,uart-r1p8", or "xlnx,xuartps"
> +- reg: Should contain UART controller registers location and length.
> +- interrupts: Should contain UART controller interrupts.
> +- clocks: Must contain phandles to the UART clocks
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names: Tuple to identify input clocks, must contain "uart_clk" and "pclk"
> +  See ../clocks/clock-bindings.txt for details.
> +
> +
> +Example:
> +	uart at e0000000 {
> +		compatible = "cdns,uart-r1p8";
> +		clocks = <&clkc 23>, <&clkc 40>;
> +		clock-names = "uart_clk", "pclk";
> +		reg = <0xE0000000 0x1000>;
> +		interrupts = <0 27 4>;
> +	};
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140423/0896ffc5/attachment.sig>
