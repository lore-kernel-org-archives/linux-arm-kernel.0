From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 15 Jan 2017 23:55:08 +0100
Subject: [PATCH 4/4] ARM64: dts: meson-gxbb-vega-s95: enable the Bluetooth
 module
In-Reply-To: <20170115223255.10350-5-martin.blumenstingl@googlemail.com>
References: <20170115223255.10350-1-martin.blumenstingl@googlemail.com>
 <20170115223255.10350-5-martin.blumenstingl@googlemail.com>
Message-ID: <a4009327-5063-49d0-e60f-f052c7d4e0a1@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 15.01.2017 um 23:32 schrieb Martin Blumenstingl:
> This takes the Bluetooth module out of reset (the reset line is
> connected to GPIOX_20) and enables uart_A which is used to configure the
> module. This is common for all Vega S95 boards.
> The device can then be initialized by running the hciattach tool:
> hciattach -s115200 /dev/ttyAML1 bcm43xx 2000000 flow -
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
> index ab497126c9a3..9e0a13b1ac93 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
> @@ -47,6 +47,7 @@
>  
>  	aliases {
>  		serial0 = &uart_AO;
> +		serial1 = &uart_A;
>  	};
>  
>  	chosen {
> @@ -100,6 +101,14 @@
>  	};
>  };
>  
> +/* This is connected to the Bluetooth module of the wifi/BT combo chip: */

Personally I would just say "Connected to the .... chip" or even just
"Bluetooth .... chip", without trailing colon, for consistency.

> +&uart_A {
> +	status = "okay";
> +	pinctrl-0 = <&uart_a_pins &uart_a_cts_rts_pins>;
> +	pinctrl-names = "default";
> +	uart-has-rtscts;
> +};
> +
>  &uart_AO {
>  	status = "okay";
>  	pinctrl-0 = <&uart_ao_a_pins>;

Tested-by: Andreas F?rber <afaerber@suse.de>

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
