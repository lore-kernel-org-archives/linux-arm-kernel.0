From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Mar 2018 20:08:22 -0600
Subject: [PATCH 4/5] dt-bindings: pwm: sunxi: add new compatible strings
In-Reply-To: <20180307020719.6675-5-andre.przywara@arm.com>
References: <20180307020719.6675-1-andre.przywara@arm.com>
 <20180307020719.6675-5-andre.przywara@arm.com>
Message-ID: <20180308020822.35utrgw3ksoldr24@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2018 at 02:07:18AM +0000, Andre Przywara wrote:
> The PWM controllers found in the Allwinner A64, H5 and H6 SoCs are fully
> compatible to the PWM controllers found in the A13 and H3.

If fully compatible, then shouldn't there be a fallback to one of the 
existing compatible strings?

> Add new compatible strings for those SoCs to the binding document, so
> that they can be safely used, together with a fallback string
> (preferably "allwinner,sun5i-a13-pwm").
> Add add the optionals "resets" property, needed by the H6.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-sun4i.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt b/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
> index 51ff54c8b8ef..b3a127a0e58c 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
> @@ -7,11 +7,17 @@ Required properties:
>      - "allwinner,sun5i-a13-pwm"
>      - "allwinner,sun7i-a20-pwm"
>      - "allwinner,sun8i-h3-pwm"
> +    - "allwinner,sun50i-a64-pwm"
> +    - "allwinner,sun50i-h5-pwm"
> +    - "allwinner,sun50i-h6-pwm"
>    - reg: physical base address and length of the controller's registers
>    - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
>      the cells format.
>    - clocks: From common clock binding, handle to the parent clock.
>  
> +Optional properties:
> +  - resets: shall be the reset control phandle for the PWM block, if required.
> +
>  Example:
>  
>  	pwm: pwm at 1c20e00 {
> -- 
> 2.14.1
> 
