From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 26 Jul 2018 09:39:11 +0200
Subject: [PATCH v2 06/18] arm64: dts: allwinner: a64: Orange Pi Win: Add
 UARTs
In-Reply-To: <20180726003532.18751-7-andre.przywara@arm.com>
References: <20180726003532.18751-1-andre.przywara@arm.com>
 <20180726003532.18751-7-andre.przywara@arm.com>
Message-ID: <20180726073911.ualwgf3t2bboeuy5@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 01:35:20AM +0100, Andre Przywara wrote:
> From: Samuel Holland <samuel@sholland.org>
> 
> The Orange Pi Win exposes several UARTs on header pin, and connects one
> to the on-board WiFi/Bluetooth chip.
> Add the pinmux definitions to the UART nodes, but keep them disabled.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> index 0cadcd59edd9..10f63d0b99cb 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> @@ -54,6 +54,10 @@
>  	aliases {
>  		ethernet0 = &emac;
>  		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +		serial4 = &uart4;
>  	};
>  
>  	chosen {
> @@ -237,12 +241,41 @@
>  	vcc-hdmi-supply = <&reg_dldo1>;
>  };
>  
> +/* On debug connector */
>  &uart0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0_pins_a>;
>  	status = "okay";
>  };
>  
> +/* Wi-Fi/BT */
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
> +	status = "okay";
> +};

What BT chip is there? Does it have serdev support? If so, that should
be enabled here.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180726/8bf0de18/attachment.sig>
