From: jbrunet@baylibre.com (jbrunet at baylibre.com)
Date: Thu, 08 Nov 2018 16:56:40 +0100
Subject: [PATCH 3/3] ARM64: dts: meson-gxl: Add support for the
 Smartlabs SML-5442TW
In-Reply-To: <1541691207-24768-3-git-send-email-christianshewitt@gmail.com>
References: <1541691207-24768-1-git-send-email-christianshewitt@gmail.com>
 <1541691207-24768-3-git-send-email-christianshewitt@gmail.com>
Message-ID: <bafa32609200e57d8efe9843247429a46916bbef.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-11-08 at 19:33 +0400, Christian Hewitt wrote:
> 
> +&audio {
> +	status = "okay";
> +};
> +
> +&aiu_i2s_dma {
> +	status = "okay";
> +};
> +
> +&i2s_dai {
> +	status = "okay";
> +};

The audio stuff has not made it's way upstream (yet) please drop this

> +
> +&cvbs_vdac_port {
> +	cvbs_vdac_out: endpoint {
> +		remote-endpoint = <&cvbs_connector_in>;
> +	};
> +};
> +
> 
[ ... ]

> +
> +/* This is connected to the Bluetooth module: */
> +&uart_A {
> +	status = "okay";
> +	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
> +	pinctrl-names = "default";

Did you forget to put 'uart-has-rtscts;' here ?

> +};
> +
> +/* This UART is brought out to the debug header */
> +&uart_AO {
> +	status = "okay";
> +	pinctrl-0 = <&uart_ao_a_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&usb0 {
> +	status = "okay";
> +};

Also, you sent a multipatch series. Such patchset should start with a cover
letter describing the general intent ... even if it is obvious.
