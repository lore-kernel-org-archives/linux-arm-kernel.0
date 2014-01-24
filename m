From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 Jan 2014 11:26:27 +0000
Subject: [PATCH v4 3/3] serial: fsl_lpuart: documented the clock
 requirement.
In-Reply-To: <1390363773-24108-4-git-send-email-yao.yuan@freescale.com>
References: <1390363773-24108-1-git-send-email-yao.yuan@freescale.com>
 <1390363773-24108-4-git-send-email-yao.yuan@freescale.com>
Message-ID: <20140124112626.GD814@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 04:09:33AM +0000, Yuan Yao wrote:
> It was previously required but not documented.
> Add the text to the binding along with the new "dmas" addition.
> 
> Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
> ---
>  Documentation/devicetree/bindings/serial/fsl-lpuart.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> index 6e1cbbf..9666f97 100644
> --- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> +++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> @@ -4,6 +4,8 @@ Required properties:
>  - compatible : Should be "fsl,<soc>-lpuart"
>  - reg : Address and length of the register set for the device
>  - interrupts : Should contain uart interrupt
> +- clocks : phandle + clock specifier pairs, one for each entry in clock-names
> +- clock-names : should contain: "ipg" - the uart clock
>  
>  Optional properties:
>  - dmas: Generic dma devicetree binding as described
> @@ -19,6 +21,8 @@ uart0: serial at 40027000 {
>  		compatible = "fsl,vf610-lpuart";
>  		reg = <0x40027000 0x1000>;
>  		interrupts = <0 61 0x00>;
> +		clocks = <&clks VF610_CLK_UART0>;
> +		clock-names = "ipg";
>  		dmas = <&edma0 0 2>,
>  			<&edma0 0 3>;
>  		dma-names = "rx","tx";

As this was a previous requirement, and this is a correction to the
documentation rather than a binding change:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
