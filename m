From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 15 Dec 2017 11:31:36 -0800
Subject: [PATCH v3 2/2] ARM64: dts: meson-axg: enable ethernet for A113D
 S400 board
In-Reply-To: <20171215021014.231308-3-yixun.lan@amlogic.com> (Yixun Lan's
 message of "Fri, 15 Dec 2017 10:10:14 +0800")
References: <20171215021014.231308-1-yixun.lan@amlogic.com>
 <20171215021014.231308-3-yixun.lan@amlogic.com>
Message-ID: <7hind7949z.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yixun Lan <yixun.lan@amlogic.com> writes:

> This is tested in the S400 dev board which use a RTL8211F PHY,
> and the pins connect to the 'eth_rgmii_y_pins' group.
>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> index 70eca1f8736a..b8c4f1913d28 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> @@ -20,3 +20,10 @@
>  &uart_AO {
>  	status = "okay";
>  };
> +
> +&ethmac {
> +	status = "okay";
> +	phy-mode = "rgmii";
> +	pinctrl-0 = <&eth_rgmii_y_pins>;
> +	pinctrl-names = "default";
> +};

Minor nit: we try to keep these sorted alphabetically.  Can you move
this above the uart_A0 one?

Note: if PATCH 1/1 had applied cleanly, I would have fixed this up
myself and not required a respin.

Kevin
