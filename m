From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 5 May 2017 23:43:06 +0200
Subject: [PATCH v3 2/4] dt-binding: meson_uart: add documentation for the
 UARTs of amlogic
In-Reply-To: <20170331165437.26227-3-hgkr.klein@gmail.com>
References: <20170331165437.26227-1-hgkr.klein@gmail.com>
 <20170331165437.26227-3-hgkr.klein@gmail.com>
Message-ID: <CAFBinCB=t6p_gmZMH3sUrVFCmnJTh2OVMT81ejdjUhs-0qyxpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Helmut,

On Fri, Mar 31, 2017 at 6:54 PM, Helmut Klein <hgkr.klein@gmail.com> wrote:
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
> +- compatible   : "amlogic,meson-uart"
> +- reg          : offset and length of the register set for the device.
> +- interrupts   : device interrupt
> +- clocks       : a list of phandle + clock-specifier pairs, one for each
> +                   entry in clock names.
> +- clocks-names : contains:
> +   * "xtal" for the baud rate clock
> +   * "core" for the core clock of none AO UARTs (optional)
I'm not sure if we should name the first clock "xtal" as on Meson8b
clk81 is used as input, see [0].
maybe "refclk" or "clkin" (the latter is already used in other meson
drivers, see sd_emmc_*, saradc, ethmac, and so on)

apart from that the whole series is a good thing (if the other small
nits - for example from Rob - are fixed)!


[0] http://elixir.free-electrons.com/linux/latest/source/arch/arm/boot/dts/meson8b.dtsi#L135
