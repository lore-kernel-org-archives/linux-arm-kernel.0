From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 7 Aug 2018 13:08:45 +0800
Subject: [PATCH v3 07/19] arm64: dts: allwinner: a64: Orange Pi Win: Add
 UARTs
In-Reply-To: <20180730123137.923-8-andre.przywara@arm.com>
References: <20180730123137.923-1-andre.przywara@arm.com>
 <20180730123137.923-8-andre.przywara@arm.com>
Message-ID: <CAGb2v66ZDyW18RzJrC1x_JNcqwKZ-jXKFYtmBMxDrgKXTvaahw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2018 at 8:31 PM, Andre Przywara <andre.przywara@arm.com> wrote:
> From: Samuel Holland <samuel@sholland.org>
>
> The Orange Pi Win exposes several UARTs on header pins, and connects one
> to the on-board WiFi/Bluetooth chip.
>
> Add the pinmux definitions to the UART nodes, but keep them disabled.
> Enable the UART1, which is wired to the Bluetooth chip, and add a serdev
> node. There is no binding for the BT8723 yet, so leave this mostly empty
> for now.

The latter part regarding Bluetooth no longer applies. Queued with this
part removed.

ChenYu

>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> index 0cadcd59edd9..e9a5640076ad 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> @@ -54,6 +54,10 @@
>         aliases {
>                 ethernet0 = &emac;
>                 serial0 = &uart0;
> +               serial1 = &uart1;
> +               serial2 = &uart2;
> +               serial3 = &uart3;
> +               serial4 = &uart4;
>         };
>
>         chosen {
> @@ -237,12 +241,41 @@
>         vcc-hdmi-supply = <&reg_dldo1>;
>  };
>
> +/* On debug connector */
>  &uart0 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&uart0_pins_a>;
>         status = "okay";
>  };
>
> +/* Bluetooth */
> +&uart1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
> +       status = "okay";
> +};
> +
> +/* On Pi-2 connector, RTS/CTS optional */
> +&uart2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart2_pins>;
> +       status = "disabled";
> +};
> +
> +/* On Pi-2 connector, RTS/CTS optional */
> +&uart3 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart3_pins>;
> +       status = "disabled";
> +};
> +
> +/* On Pi-2 connector (labeled for SPI1), RTS/CTS optional */
> +&uart4 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart4_pins>;
> +       status = "disabled";
> +};
> +
>  &usb_otg {
>         dr_mode = "otg";
>         status = "okay";
> --
> 2.14.4
>
