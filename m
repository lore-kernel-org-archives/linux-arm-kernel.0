From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 12 Nov 2018 09:18:10 +0100
Subject: [PATCH v2 1/4] dt-bindings: hwlock: Document STM32 hwspinlock
 bindings
In-Reply-To: <20181108090502.14543-2-benjamin.gaignard@st.com>
References: <20181108090502.14543-1-benjamin.gaignard@st.com>
 <20181108090502.14543-2-benjamin.gaignard@st.com>
Message-ID: <427f9053-22c2-92f7-c60a-d54505185068@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benjamin

On 11/8/18 10:04 AM, Benjamin Gaignard wrote:
> Add bindings for STM32 hardware spinlock device
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> version 2 :
> - change clock name from hwspinlock to hsem to be align with hardware
>    documentation
> 
>   .../bindings/hwlock/st,stm32-hwspinlock.txt        | 23 ++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt b/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
> new file mode 100644
> index 000000000000..6e933b218574
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
> @@ -0,0 +1,23 @@
> +STM32 Hardware Spinlock Device Binding
> +-------------------------------------
> +
> +Required properties :
> +- compatible : should be "st,stm32-hwspinlock".
> +- reg : the register address of hwspinlock.
> +- #hwlock-cells : hwlock users only use the hwlock id to represent a specific
> +	hwlock, so the number of cells should be <1> here.
> +- clock-names : Must contain "hwspinlock".

"hwspinlock" --> "hsem" ?

> +- clocks : Must contain a phandle entry for the clock in clock-names, see the
> +	common clock bindings.
> +
> +Please look at the generic hwlock binding for usage information for consumers,
> +"Documentation/devicetree/bindings/hwlock/hwlock.txt"
> +
> +Example of hwlock provider:
> +	hwspinlock at 4c000000 {
> +		compatible = "st,stm32-hwspinlock";
> +		#hwlock-cells = <1>;
> +		reg = <0x4c000000 0x400>;
> +		clocks = <&rcc HSEM>;
> +		clock-names = "hsem";
> +	};
> 
