From: robh@kernel.org (Rob Herring)
Date: Sat, 21 Jan 2017 14:53:45 -0600
Subject: [PATCH 1/3] ARM: dts: Add support for phyCORE-AM335x PCM-953
 carrier board
In-Reply-To: <1484831270-7251-1-git-send-email-t.remmet@phytec.de>
References: <1484831270-7251-1-git-send-email-t.remmet@phytec.de>
Message-ID: <20170121205345.oij67ai5d7q7k74d@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 02:07:48PM +0100, Teresa Remmet wrote:
> The phyCORE-AM335x development kit is a combination of the
> phyCORE-AM335x SoM and a PCM-953 carrier board. The features
> of the PCM-953 are:
> * ETH phy on carrier board: 1x RGMII
> * 1x CAN
> * Up to 4x UART
> * USB0 (otg)
> * USB1 (host)
> * SD slot
> * User gpio-keys
> * User LEDs
> 
> Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
> Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  .../devicetree/bindings/arm/omap/omap.txt          |   3 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/am335x-pcm-953.dtsi              | 303 +++++++++++++++++++++
>  arch/arm/boot/dts/am335x-phycore-rdk.dts           |  27 ++
>  4 files changed, 334 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am335x-pcm-953.dtsi
>  create mode 100644 arch/arm/boot/dts/am335x-phycore-rdk.dts

[...]

> +	user_leds: user_leds {
> +		compatible = "gpio-leds";
> +	};
> +
> +	user_buttons: user_buttons {
> +		compatible = "gpio-keys";
> +	};

With only a compatible, I don't think there's much gain to split these 2 
nodes. Otherwse,

Acked-by: Rob Herring <robh@kernel.org>

> +&user_buttons {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&user_buttons_pins>;
> +	status = "okay";
> +
> +	button at 0 {
> +		label = "home";
> +		linux,code = <KEY_HOME>;
> +		gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
> +		gpio-key,wakeup;
> +	};
> +
> +	button at 1 {
> +		label = "menu";
> +		linux,code = <KEY_MENU>;
> +		gpios = <&gpio3 8 GPIO_ACTIVE_HIGH>;
> +		gpio-key,wakeup;
> +	};
> +};
> +
> +&user_leds {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&user_leds_pins>;
> +	status = "okay";
> +
> +	green {
> +		label = "green:user";
> +		gpios = <&gpio1 30 GPIO_ACTIVE_HIGH>;
> +		linux,default-trigger = "gpio";
> +		default-state = "on";
> +	};
> +
> +	yellow {
> +		label = "yellow:user";
> +		gpios = <&gpio1 31 GPIO_ACTIVE_LOW>;
> +		linux,default-trigger = "gpio";
> +		default-state = "on";
> +	};
> +};
