From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 22 Apr 2013 08:41:23 +0200
Subject: [PATCH 8/8] ARM: mx5: Add support for DENX M53EVK
In-Reply-To: <1366579808-12067-8-git-send-email-marex@denx.de>
References: <1366579808-12067-1-git-send-email-marex@denx.de>
 <1366579808-12067-8-git-send-email-marex@denx.de>
Message-ID: <20130422064123.GG10373@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 21, 2013 at 11:30:08PM +0200, Marek Vasut wrote:
> This patch adds support for the DENX M53EVK board. The board currently supports
> NAND, Ethernet, UART, CAN, I2C.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
> +/ {
> +	model = "DENX M53EVK";
> +	compatible = "denx,imx53-m53evk", "fsl,imx53";
> +
> +	memory {
> +		reg = <0x70000000 0x20000000>;
> +	};
> +
> +	soc {
> +		display at di0 {
> +			compatible = "fsl,imx-parallel-display";
> +			crtcs = <&ipu 0>;
> +			interface-pix-fmt = "rgb24";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_ipu_disp1_1>;
> +
> +			display-timings {
> +				800x480p60 {
> +					native-mode;
> +					clock-frequency = <31500000>;
> +					hactive = <800>;
> +					vactive = <480>;
> +					hfront-porch = <40>;
> +					hback-porch = <88>;
> +					hsync-len = <128>;
> +					vback-porch = <33>;
> +					vfront-porch = <9>;
> +					vsync-len = <3>;
> +					vsync-active = <1>;
> +				};
> +			};
> +		};
> +
> +		display at di1 {
> +			compatible = "fsl,imx-parallel-display";
> +			crtcs = <&ipu 1>;
> +			interface-pix-fmt = "rgb24";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_ipu_disp2_1>;
> +
> +			display-timings {
> +				800x480p60 {
> +					native-mode;
> +					clock-frequency = <31500000>;
> +					hactive = <800>;
> +					vactive = <480>;
> +					hfront-porch = <40>;
> +					hback-porch = <88>;
> +					hsync-len = <128>;
> +					vback-porch = <33>;
> +					vfront-porch = <9>;
> +					vsync-len = <3>;
> +					vsync-active = <1>;
> +				};
> +			};
> +		};

This board has two identical displays?

> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&led_pin_gpio>;
> +
> +		user1 {
> +			label = "user1";
> +			gpios = <&gpio2 8 0>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		user2 {
> +			label = "user2";
> +			gpios = <&gpio2 9 0>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};

Two heartbeat LEDs? Why not use one for something else?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
