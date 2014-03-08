From: robherring2@gmail.com (Rob Herring)
Date: Sat, 8 Mar 2014 13:34:33 -0600
Subject: [PATCH RFC v2 10/11] tty: cadence: Document DT binding
In-Reply-To: <1394219614-3197-11-git-send-email-soren.brinkmann@xilinx.com>
References: <1394219614-3197-1-git-send-email-soren.brinkmann@xilinx.com>
 <1394219614-3197-11-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <CAL_JsqKUSDbZbx9k6bO3O7=2gb3L0Rs_xnbZtydeSKpji1Yjmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 7, 2014 at 1:13 PM, Soren Brinkmann
<soren.brinkmann@xilinx.com> wrote:
> Add binding documentation for the Cadence UART.
>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> Acked-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
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
> +       uart at e0000000 {
> +               compatible = "cdns,uart-r1p8";
> +               clocks = <&clkc 23>, <&clkc 40>;
> +               clock-names = "uart_clk", "pclk";
> +               reg = <0xE0000000 0x1000>;
> +               interrupts = <0 27 4>;
> +       };
> --
> 1.9.0.1.g4196000
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
