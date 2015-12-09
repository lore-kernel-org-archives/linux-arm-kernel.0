From: robh@kernel.org (Rob Herring)
Date: Tue, 8 Dec 2015 21:41:37 -0600
Subject: [PATCH v3 2/9] Documentation: dt-bindings: Document STM32
 pinctrl driver DT bindings
In-Reply-To: <1449578711-6141-3-git-send-email-mcoquelin.stm32@gmail.com>
References: <1449578711-6141-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1449578711-6141-3-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <20151209034137.GA15954@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2015 at 01:45:04PM +0100, Maxime Coquelin wrote:
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> ---
>  .../bindings/pinctrl/st,stm32-pinctrl.txt          | 126 +++++++++++++++++++++
>  1 file changed, 126 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
> new file mode 100644
> index 0000000..7b4800c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
> @@ -0,0 +1,126 @@
> +* STM32 GPIO and Pin Mux/Config controller
> +
> +STMicroelectronics's STM32 MCUs intregrate a GPIO and Pin mux/config hardware
> +controller. It controls the input/output settings on the available pins and
> +also provides ability to multiplex and configure the output of various on-chip
> +controllers onto these pads.
> +
> +Pin controller node:
> +Required properies:
> + - compatible: value should be one of the following:
> +   (a) "st,stm32f429-pinctrl"
> + - #address-cells: The value of this property must be 1
> + - #size-cells	: The value of this property must be 1
> + - ranges	: defines mapping between pin controller node (parent) to
> +   gpio-bank node (children).
> + - pins-are-numbered: Specify the subnodes are using numbered pinmux to
> +   specify pins.
> +
> +GPIO controller/bank node:
> +Required properties:
> + - gpio-controller : Indicates this device is a GPIO controller
> + - #gpio-cells	  : Should be two.
> +			The first cell is the pin number
> +			The second one is the polarity:
> +				- 0 for active high
> +				- 1 for active low
> + - reg		  : The gpio address range, relative to the pinctrl range
> + - clocks	  : clock that drives this bank
> + - st,bank-name	  : Should be a name string for this bank as specified in
> +   the datasheet

How do you intend to use this? We should come up with something generic 
or drop it.

Rob
