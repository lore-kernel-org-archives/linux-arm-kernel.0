From: robh@kernel.org (Rob Herring)
Date: Mon, 3 Apr 2017 11:52:39 -0500
Subject: [PATCH v3 2/4] dt-binding: meson_uart: add documentation for the
 UARTs of amlogic
In-Reply-To: <20170331165437.26227-3-hgkr.klein@gmail.com>
References: <20170331165437.26227-1-hgkr.klein@gmail.com>
 <20170331165437.26227-3-hgkr.klein@gmail.com>
Message-ID: <20170403165239.2k2sajeu2vout7hf@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 31, 2017 at 06:54:35PM +0200, Helmut Klein wrote:
> Add the documentation for the device tree binding of meson_uart
> 
> Signed-off-by: Helmut Klein <hgkr.klein@gmail.com>
> ---
>  .../bindings/serial/amlogic,meson_uart.txt         | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson_uart.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson_uart.txt b/Documentation/devicetree/bindings/serial/amlogic,meson_uart.txt
> new file mode 100644
> index 000000000000..8250a191c2fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/amlogic,meson_uart.txt
> @@ -0,0 +1,30 @@
> +* Amlogic Meson UART, used in multiple SoCs (e.g. S905, s905X, ...)
> +
> +Required properties:
> +- compatible	: "amlogic,meson-uart"

Should have SoC specific compatible strings in addition.

> +- reg		: offset and length of the register set for the device.
> +- interrupts	: device interrupt
> +- clocks	: a list of phandle + clock-specifier pairs, one for each
> +		    entry in clock names.
> +- clocks-names	: contains:
> +   * "xtal" for the baud rate clock
> +   * "core" for the core clock of none AO UARTs (optional)
> +
> +e.g.
> +uart_A: serial at 84c0 {
> +	compatible = "amlogic,meson-uart";
> +	reg = <0x0 0x84c0 0x0 0x14>;
> +	pinctrl-0 = <&uart_a_pins &uart_a_cts_rts_pins>;
> +	interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
> +	clocks = <&xtal>, <&clkc CLKID_UART0>;
> +	clock-names = "xtal", "core";
> +	status = "ok";

Drop status from examples.

> +};
> +
> +Note: Each port should have an alias correctly numbered in "aliases" node.

True for pretty much any uart, so you can drop this.

> +
> +e.g.
> +aliases {
> +	serial0 = &uart_AO;
> +	serial1 = &uart_A;
> +};
> --
> 2.11.0
> 
