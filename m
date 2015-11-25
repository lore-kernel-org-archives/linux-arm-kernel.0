From: robh@kernel.org (Rob Herring)
Date: Wed, 25 Nov 2015 14:07:29 -0600
Subject: [RFC PATCH 03/10] dt-bindings: document the MPS2 UART bindings
In-Reply-To: <1448447621-17900-4-git-send-email-vladimir.murzin@arm.com>
References: <1448447621-17900-1-git-send-email-vladimir.murzin@arm.com>
 <1448447621-17900-4-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20151125200729.GJ30473@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 10:33:34AM +0000, Vladimir Murzin wrote:
> This adds documentation of device tree bindings for the
> UART found on ARM MPS2 platform
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>

Why did ARM invent a new UART?

Acked-by: Rob Herring <robh@kernel.org

> ---
>  .../devicetree/bindings/serial/arm,mps2-uart.txt   |   22 ++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/arm,mps2-uart.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/arm,mps2-uart.txt b/Documentation/devicetree/bindings/serial/arm,mps2-uart.txt
> new file mode 100644
> index 0000000..b3f7cb1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/arm,mps2-uart.txt
> @@ -0,0 +1,22 @@
> +ARM MPS2 UART
> +
> +Required properties:
> +- compatible	: Should be "arm,mps2-uart"
> +- reg		: Address and length of the register set
> +- interrupts	: Reference to the UART RX, TX and overrun interrupts
> +
> +Required clocking property:
> +- clocks	: The input clock of the UART
> +
> +
> +Examples:
> +
> +uart0: serial at 40004000 {
> +	compatible = "arm,mps2-uart";
> +	reg = <0x40004000 0x1000>;
> +	interrupts = <0 1 12>;
> +	clocks = <&sysclk>;
> +};
> +
> +
> +
> -- 
> 1.7.9.5
> 
