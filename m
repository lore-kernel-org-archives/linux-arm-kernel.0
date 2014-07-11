From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Jul 2014 09:24:25 +0100
Subject: [PATCH 2/3] usb: host: st-hcd: Add st-hcd devicetree bindings
 documentation.
In-Reply-To: <1405005486-26355-3-git-send-email-peter.griffin@linaro.org>
References: <1405005486-26355-1-git-send-email-peter.griffin@linaro.org>
 <1405005486-26355-3-git-send-email-peter.griffin@linaro.org>
Message-ID: <20140711082425.GJ11948@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Jul 2014, Peter Griffin wrote:

> This patch documents the device tree documentation required for
> the ST HCD controller found in STMicroelectronics SoCs.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/st-hcd.txt | 51 ++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/st-hcd.txt

Just some nits:

> +Example:
> +
> +usb0: usb at fe100000 {
> +	compatible	= "st,usb-300x";
> +	reg		= <0xfe1ffc00 0x100>,
> +			  <0xfe1ffe00 0x100>;
> +	reg-names	= "ohci", "ehci";
> +
> +	interrupts	=  <GIC_SPI 148 IRQ_TYPE_NONE>,
> +			   <GIC_SPI 149 IRQ_TYPE_NONE>;
> +	interrupt-names	= "ehci","ohci";

s/","/", "

> +	pinctrl-names	= "default";
> +	pinctrl-0	= <&pinctrl_usb0>;
> +	clocks		= <&clk_s_a1_ls CLK_ICN_IF_2>,
> +			  <&clockgen_b0 0>;
> +	clock-names	= "ic", "ohci";
> +
> +	resets		= <&powerdown STIH416_USB0_POWERDOWN>,
> +			  <&softreset STIH416_USB0_SOFTRESET>;
> +	reset-names	= "power", "softreset";
> +
> +	phys = <&usb2_phy>;
> +	phy-names = "usb2-phy";

Tabbing of the '='s not consistent.

> +};
> +
> +

Too many '\n' at EOF.

Nothing controversial here, so once this nits are rectified:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
