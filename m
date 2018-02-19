From: robh@kernel.org (Rob Herring)
Date: Mon, 19 Feb 2018 14:35:23 -0600
Subject: [PATCH 05/10] dt-bindings: gpio: Add gpio nodes for Actions S900
 SoC
In-Reply-To: <20180217204433.3095-6-manivannan.sadhasivam@linaro.org>
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
 <20180217204433.3095-6-manivannan.sadhasivam@linaro.org>
Message-ID: <20180219203523.rhvbnym7oomzahwi@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 18, 2018 at 02:14:28AM +0530, Manivannan Sadhasivam wrote:
> Add gpio nodes for Actions Semi S900 SoC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/gpio/actions,owl-gpio.txt         | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt b/Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
> new file mode 100644
> index 000000000000..4cd4cb7bfd1b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
> @@ -0,0 +1,15 @@
> +* Actions Semi OWL GPIO controller bindings
> +
> +- compatible      : Should be "actions,s900-gpio"
> +- reg             : Address and range of the GPIO controller registers.
> +- gpio-controller : Marks the device node as a GPIO controller.
> +- #gpio-cells     : Should be <2>. The first cell is the gpio number and
> +                    the second cell is used to specify optional parameters.

Doesn't do interrupts?

> +
> +Example:
> +       gpio: gpio at e01b0000 {
> +               compatible = "actions,s900-gpio";
> +               reg = <0x0 0xe01b0000 0x0 0x1000>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +       };
> -- 
> 2.14.1
> 
