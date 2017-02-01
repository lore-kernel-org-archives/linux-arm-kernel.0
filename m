From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Feb 2017 10:35:00 -0600
Subject: [PATCH 3/5] Documentation: dt: iio: document stm32 exti trigger
In-Reply-To: <1485784663-19505-4-git-send-email-fabrice.gasnier@st.com>
References: <1485784663-19505-1-git-send-email-fabrice.gasnier@st.com>
 <1485784663-19505-4-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20170201163500.ivxnxejurhzzoctl@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 02:57:41PM +0100, Fabrice Gasnier wrote:
> Add dt documentation for st,stm32-exti-trigger.
> EXTi gpio signal can be routed internally as trigger source for various

s/gpio/GPIO/

> IPs (e.g. for ADC or DAC conversions).

Please use "dt-bindings: iio:" for the subject prefix.

> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  .../bindings/iio/trigger/st,stm32-exti-trigger.txt      | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/trigger/st,stm32-exti-trigger.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/trigger/st,stm32-exti-trigger.txt b/Documentation/devicetree/bindings/iio/trigger/st,stm32-exti-trigger.txt
> new file mode 100644
> index 0000000..ebf2645
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/trigger/st,stm32-exti-trigger.txt
> @@ -0,0 +1,17 @@
> +STMicroelectronics STM32 EXTI trigger bindings
> +
> +EXTi gpio signal can be routed internally as trigger source for various

s/gpio/GPIO/

> +IPs (e.g. for ADC or DAC conversions).
> +
> +Contents of a stm32 exti trigger root node:

Drop "root"

> +-------------------------------------------
> +Required properties:
> +- compatible: Should be "st,stm32-exti-trigger"

This whole binding looks a bit suspicious. Is this actually a h/w block? 
What makes it stm32 specific? Seems like the gpio properties should just 
be part of the ADC or DAC that they trigger.

> +- extiN-gpio: optional gpio line that may be used as external trigger source

-gpios is the preferred form.

> +  (e.g. N may be 0..15. For example, exti11-gpio can trig ADC on stm32f4).
> +
> +Example:
> +	triggers {
> +		compatible = "st,stm32-exti-trigger";
> +		exti11-gpio=<&gpioa 11 0>;

spaces around the "=".

> +	};
> -- 
> 1.9.1
> 
