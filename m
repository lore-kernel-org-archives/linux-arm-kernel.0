From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 26 Feb 2018 09:44:33 +0100
Subject: [PATCH v2 1/4] dt-bindings: pwm: binding allwinner sun8i.
In-Reply-To: <20180225135045.GA14508@arx-s1>
References: <20180225135045.GA14508@arx-s1>
Message-ID: <20180226084433.jcahdixnz63jo34m@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Feb 25, 2018 at 09:50:45PM +0800, hao_zhang wrote:
> This patch adds allwinner sun8i pwm binding documents.
> 
> Signed-off-by: hao_zhang <hao5781286@gmail.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-sun8i.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> new file mode 100644
> index 0000000..e8c48be
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> @@ -0,0 +1,18 @@
> +Allwinner sun8i R40/V40/T3 SoC PWM controller
> +
> +Required properties:
> +  - compatible: should be one of:
> +    - "allwinner,sun8i-r40-pwm"
> +  - reg: physical base address and length of the controller's registers
> +  - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
> +    the cells format.
> +  - clocks: From common clock binding, handle to the parent clock.
> +
> +Example:
> +
> +pwm: pwm at 1c23400 {
> +	     compatible = "allwinner,sun8i-pwm";

The compatible you have here isn't the one documented.

> +	     reg = <0x01c23400 0x154>;

And the size isn't correct, even though that doesn't really make any
difference here.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180226/67e22370/attachment-0001.sig>
