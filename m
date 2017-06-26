From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Jun 2017 13:16:58 -0500
Subject: [PATCH v2 7/8] dt-bindings: iio: Add STM32 LPTimer quadrature
 encoder and counter
In-Reply-To: <1498055415-31513-8-git-send-email-fabrice.gasnier@st.com>
References: <1498055415-31513-1-git-send-email-fabrice.gasnier@st.com>
 <1498055415-31513-8-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20170626181658.nbl7jmaru7bnoigg@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 04:30:14PM +0200, Fabrice Gasnier wrote:
> Add documentation for STMicroelectronics STM32 Low-Power Timer
> quadrature encoder and counter binding.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v2:
> - s/Low Power/Low-Power
> - remove leading 0x in example (parent node)
> - improve properties descriptions
> ---
>  .../bindings/iio/counter/stm32-lptimer-cnt.txt     | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt b/Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt
> new file mode 100644
> index 0000000..b9fd014
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt
> @@ -0,0 +1,27 @@
> +STMicroelectronics STM32 Low-Power Timer quadrature encoder and counter
> +
> +STM32 Low-Power Timer provides several counter modes. It can be used as:
> +- quadrature encoder to detect angular position and direction of rotary
> +  elements, from IN1 and IN2 input signals.
> +- simple counter from IN1 input signal.
> +
> +Must be a sub-node of an STM32 Low-Power Timer device tree node.
> +See ../mfd/stm32-lptimer.txt for details about the parent node.
> +
> +Required properties:
> +- compatible:		Must be "st,stm32-lptimer-counter".
> +- pinctrl-names: 	Set to "default".
> +- pinctrl-0: 		List of phandles pointing to pin configuration nodes,
> +			to set IN1/IN2 pins in mode of operation for Low-Power
> +			Timer input on external pin.
> +
> +Example:
> +	lptimer1: lptimer at 40002400 {

timer at ...

With that,

Acked-by: Rob Herring <robh@kernel.org>
