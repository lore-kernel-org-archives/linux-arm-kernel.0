From: philippe.cornu@st.com (Philippe CORNU)
Date: Thu, 6 Jul 2017 14:21:26 +0000
Subject: [PATCH v1 2/3] dt-bindings: display: panel: Add support for Orise
 Tech otm8009a dsi panel
In-Reply-To: <1499185805-23354-3-git-send-email-philippe.cornu@st.com>
References: <1499185805-23354-1-git-send-email-philippe.cornu@st.com>
 <1499185805-23354-3-git-send-email-philippe.cornu@st.com>
Message-ID: <c7caa8fc-076b-c2ad-5210-19458f89dab7@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/04/2017 06:30 PM, Philippe CORNU wrote:
> The Orise Tech OTM8009A is a 3.97" 480x800 TFT LCD panel connected using
> a MIPI-DSI video interface. Its backlight is managed through the DSI link.
> 
> Signed-off-by: Philippe CORNU <philippe.cornu@st.com>
> ---
>   .../bindings/display/panel/orisetech,otm8009a.txt    | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt b/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt
> new file mode 100644
> index 0000000..0bb8237
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt
> @@ -0,0 +1,20 @@
> +Orise Tech OTM8009A 3.97" 480x800 TFT LCD panel (MIPI-DSI video mode)
> +
> +The Orise Tech OTM8009A is a 3.97" 480x800 TFT LCD panel connected using
> +a MIPI-DSI video interface. Its backlight is managed through the DSI link.
> +
> +Required properties:
> +  - compatible: "orisetech,otm8009a"
> +  - reg: the virtual channel number of a DSI peripheral
> +  - reset-gpios: a GPIO spec for the reset pin (active low). (Optional)
> +
> +Example:
> +&dsi {
> +	...
> +
> +	panel at 0 {
> +		compatible = "orisetech,otm8009a";
> +		reg = <0>;
> +		reset-gpios = <&gpioh 7 0>;

Hi All,
I should have written instead:
  +		reset-gpios = <&gpioh 7 GPIO_ACTIVE_LOW>;

reset-gpios is active low and the define GPIO_ACTIVE_LOW = 1 so the 
example was not good.

I will send soon the v2 with the correction.
Many thanks
Philippe


> +	};
> +};
> 
