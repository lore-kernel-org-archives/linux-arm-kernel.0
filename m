From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 7 Dec 2015 02:41:10 +0100
Subject: [PATCH/RESEND] ARM: dts: kirkwood: Add DTS for Zyxel NSA325
In-Reply-To: <1449334057-6008-1-git-send-email-ulli.kroll@googlemail.com>
References: <1449334057-6008-1-git-send-email-ulli.kroll@googlemail.com>
Message-ID: <20151207014110.GB19715@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +		serial at 12000 {
> +			status = "ok";
> +		};
> +
> +		sata at 80000 {
> +			status = "okay";
> +			nr-ports = <2>;
> +		};
> +	};
> +
> +		gpio-leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&pmx_led_hdd2_green &pmx_led_hdd2_red
> +			     &pmx_led_usb_green
> +			     &pmx_led_sys_green &pmx_led_sys_orange
> +			     &pmx_led_copy_green &pmx_led_copy_red
> +			     &pmx_led_hdd1_green &pmx_led_hdd1_red>;
> +		pinctrl-names = "default";

Hi Hans

There is some odd indentation going on here, and in other parts of the
file.

> +
> +&nand {
> +	status = "okay";
> +	chip-delay = <35>;
> +
> +	partition at 0 {
> +		label = "uboot";
> +		reg = <0x0000000 0x0100000>;
> +	};

The partitions should be inside a partitions node. See
Documentation/devicetree/bindings/mtd/partition.txt
