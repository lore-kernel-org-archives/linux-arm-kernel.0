From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 5 Mar 2017 12:16:28 +0000
Subject: [PATCH v3 3/6] dt-bindings: iio: document interrupt trigger
 support
In-Reply-To: <1488300679-3259-4-git-send-email-fabrice.gasnier@st.com>
References: <1488300679-3259-1-git-send-email-fabrice.gasnier@st.com>
 <1488300679-3259-4-git-send-email-fabrice.gasnier@st.com>
Message-ID: <e6e2f05f-0dc0-f2a3-064b-268776a413c5@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/02/17 16:51, Fabrice Gasnier wrote:
> Document interrupt trigger that takes a generic interrupt, and
> can be used as trigger source for sampling devices such as sensors,
> ADCs...
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
I'm not convinced we want the earlier device tree binding doc at all.
In the vast majority of cases that chunk on providers is irrelevant.
What matters is to document the specific case as you have done here.

So this one I like, the earlier document less so, simply because
it repeats what this more specific document has described.

So Rob, what do you think of 'just' this bit?
> ---
>  .../bindings/iio/trigger/iio-trig-interrupt.txt    | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/trigger/iio-trig-interrupt.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/trigger/iio-trig-interrupt.txt b/Documentation/devicetree/bindings/iio/trigger/iio-trig-interrupt.txt
> new file mode 100644
> index 0000000..9de9856
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/trigger/iio-trig-interrupt.txt
> @@ -0,0 +1,22 @@
> +Interrupt based trigger
> +
> +Any internal or external interrupt may be used as trigger source for
> +devices like sensors, ADCs... As an example, external signal can be
> +routed to a GPIO, and turned into an interrupt driven trigger.
> +
> +Required properties:
> +- compatible: Should be "interrupt-trigger"
> +- interrupts: The interrupt used as trigger. Generic interrupt client node as
> +  described in ../../interrupt-controller/interrupts.txt
> +
> +Optional properties:
> +- #io-trigger-cells = <0>; See the IIO bindings, IIO trigger providers
> +  and consumers sections in ../iio-bindings.txt
> +
> +Example:
> +	trig0: interrupt-trigger0 {
> +		#io-trigger-cells = <0>;
> +		compatible = "interrupt-trigger";
> +		interrupts = <11 0>;
> +		interrupt-parent = <&gpioa>;
> +	}
> 
