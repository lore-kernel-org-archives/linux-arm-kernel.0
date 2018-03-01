From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 1 Mar 2018 14:03:52 +0000
Subject: [PATCH v2 1/2] dt-bindings: stm32: Add bindings for Extended
 TrustZone Protection
In-Reply-To: <20180301135806.19982-2-benjamin.gaignard@st.com>
References: <20180301135806.19982-1-benjamin.gaignard@st.com>
 <20180301135806.19982-2-benjamin.gaignard@st.com>
Message-ID: <20180301140351.gokvstohs3mghz5q@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 02:58:05PM +0100, Benjamin Gaignard wrote:
> Extended TrustZone Protection driver is very basic and only needs
> to know where are the registers (no clock, no interrupt)
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../bindings/arm/stm32/st,stm32mp1-etzpc.txt       | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/stm32/st,stm32mp1-etzpc.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/stm32/st,stm32mp1-etzpc.txt b/Documentation/devicetree/bindings/arm/stm32/st,stm32mp1-etzpc.txt
> new file mode 100644
> index 000000000000..9407e37f7d15
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/stm32/st,stm32mp1-etzpc.txt
> @@ -0,0 +1,25 @@
> +STMicroelectronics STM32 Extended TrustZone Protection driver
> +
> +Required properties:
> + - compatible : value should be "st,stm32mp1-etzpc"
> + - reg : physical base address of the IP registers and length of memory
> +	 mapped region.
> + - protected-devices: list of phandle of devices protected by etzpc.
> +		      Because etzpc driver rely on the phandle index in
> +		      the list, holes must be filled with a disabled node.

... where the index corresponds to what, exactly?

Padding with a disabled node seems very hacky.

Thanks,
Mark.

> +
> +Example for stm32mp1:
> +
> +reserved: disabled_node {
> +	status = "disabled";
> +};
> +
> +etzpc: etzpc at 5c007000 {
> +	compatible = "st,stm32mp1-etzpc";
> +	reg = <0x5c007000 0x400>;
> +		protected-devices = <&usart1>,
> +				    <&spi6>,
> +				    <&i2c4>,
> +				    <&reserved>,
> +				    <&rng1>;
> +};
> -- 
> 2.15.0
> 
