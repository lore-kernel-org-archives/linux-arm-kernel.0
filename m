From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 23 Mar 2017 16:45:57 +0000
Subject: [PATCH v3 04/11] Documentation: DT: bindings: mfd: add A33 GPADC
 binding
In-Reply-To: <20170321153611.16228-5-quentin.schulz@free-electrons.com>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
 <20170321153611.16228-5-quentin.schulz@free-electrons.com>
Message-ID: <20170323164557.a7h2eolmxeqfwg6b@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Mar 2017, Quentin Schulz wrote:

> This patch adds documentation for the A33 GPADC binding.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
> 
> v3:
>   - fixed missing allwinner in front of compatible,
>   - updated compatible to allwinner,sun8i-a33-ths to better reflect the
>   datasheet's name,
>   - updated example's DT node name and label to ths,
> 
> added in v2
> 
>  .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt

This is going to need a DT Ack.

> diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> new file mode 100644
> index 0000000..badff36
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> @@ -0,0 +1,59 @@
> +Allwinner SoCs' GPADC Device Tree bindings
> +------------------------------------------
> +The Allwinner SoCs all have an ADC that can also act as a thermal sensor
> +and sometimes as a touchscreen controller.
> +
> +Required properties:
> +  - compatible: "allwinner,sun8i-a33-ths",
> +  - reg: mmio address range of the chip,
> +  - #thermal-sensor-cells: shall be 0,
> +  - #io-channel-cells: shall be 0,
> +
> +Example:
> +	ths: ths at 01c25000 {
> +		compatible = "allwinner,sun8i-a33-ths";
> +		reg = <0x01c25000 0x100>;
> +		#thermal-sensor-cells = <0>;
> +		#io-channel-cells = <0>;
> +	};
> +
> +sun4i, sun5i and sun6i SoCs are also supported via the older binding:
> +
> +sun4i resistive touchscreen controller
> +--------------------------------------
> +
> +Required properties:
> + - compatible: "allwinner,sun4i-a10-ts", "allwinner,sun5i-a13-ts" or
> +   "allwinner,sun6i-a31-ts"
> + - reg: mmio address range of the chip
> + - interrupts: interrupt to which the chip is connected
> + - #thermal-sensor-cells: shall be 0
> +
> +Optional properties:
> + - allwinner,ts-attached	 : boolean indicating that an actual touchscreen
> +				   is attached to the controller
> + - allwinner,tp-sensitive-adjust : integer (4 bits)
> +				   adjust sensitivity of pen down detection
> +				   between 0 (least sensitive) and 15
> +				   (defaults to 15)
> + - allwinner,filter-type	 : integer (2 bits)
> +				   select median and averaging filter
> +				   samples used for median / averaging filter
> +				   0: 4/2
> +				   1: 5/3
> +				   2: 8/4
> +				   3: 16/8
> +				   (defaults to 1)
> +
> +Example:
> +
> +	rtp: rtp at 01c25000 {
> +		compatible = "allwinner,sun4i-a10-ts";
> +		reg = <0x01c25000 0x100>;
> +		interrupts = <29>;
> +		allwinner,ts-attached;
> +		#thermal-sensor-cells = <0>;
> +		/* sensitive/noisy touch panel */
> +		allwinner,tp-sensitive-adjust = <0>;
> +		allwinner,filter-type = <3>;
> +	};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
