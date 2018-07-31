From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 31 Jul 2018 14:22:43 +0200
Subject: [PATCH v3 08/19] arm64: dts: allwinner: a64: Orange Pi Win: Add
 serdev BT node
In-Reply-To: <20180730123137.923-9-andre.przywara@arm.com>
References: <20180730123137.923-1-andre.przywara@arm.com>
 <20180730123137.923-9-andre.przywara@arm.com>
Message-ID: <20180731122243.zw2wgpvv2j4zv5hf@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2018 at 01:31:26PM +0100, Andre Przywara wrote:
> The Orange Pi Win has the RTL8723BS WiFi/Bluetooth chip soldered on the
> board, with the Bluetooth part connected to UART1.
> 
> At the moment there is no mainline driver for the BT part yet, although
> there is one in development. However as this does not include a DT binding,
> we just go with an empty stub for now to denote that the BT chip is on
> that UART. This can later be filled with the right properties.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> index e9a5640076ad..87c32635085b 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> @@ -253,6 +253,9 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
>  	status = "okay";
> +
> +	rtl8723bs-bt {
> +	};

The unit name should be the class of the device, so bluetooth would a
better name. However, I'm not even sure this is relevant, and that we
should merge this patch. It doesn't provide any info that isn't
already there.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
