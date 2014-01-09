From: klightspeed@killerwolves.net (Ben Peddell)
Date: Thu, 09 Jan 2014 12:05:14 +1000
Subject: [PATCH RFC RFT 2/2] ARM: Kirkwood: Add support for many Synology
 NAS devices
In-Reply-To: <1389052027-16819-3-git-send-email-andrew@lunn.ch>
References: <1389052027-16819-1-git-send-email-andrew@lunn.ch>
 <1389052027-16819-3-git-send-email-andrew@lunn.ch>
Message-ID: <52CE03DA.3000007@killerwolves.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/14 09:47, Andrew Lunn wrote:
> Add device tree fragments and files to support many of the kirkwood
> based Synology NAS devices. This is a translation of the board setup
> file maintained by Ben Peddell <klightspeed@killerwolves.net>

[snip]

> diff --git a/arch/arm/boot/dts/synology/fan-gpios-32.dtsi b/arch/arm/boot/dts/synology/fan-gpios-32.dtsi
> new file mode 100644
> index 000000000000..aea1a0dce906
> --- /dev/null
> +++ b/arch/arm/boot/dts/synology/fan-gpios-32.dtsi
> @@ -0,0 +1,34 @@
> +/*
> + * Andrew Lunn <andrew@lunn.ch>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +/ {
> +	ocp at f1000000 {
> +		pinctrl: pinctrl at 10000 {
> +
> +			pmx_fan_32: pmx-fan-32 {
> +				marvell,pins = "mpp32";
> +				marvell,function = "gpio";
> +			};
> +			pmx_fan_33: pmx-fan-33 {
> +				marvell,pins = "mpp33";
> +				marvell,function = "gpio";

This should be "gpo"

> +			};
> +			pmx_fan_34: pmx-fan-34 {
> +				marvell,pins = "mpp34";
> +				marvell,function = "gpio";
> +			};
> +		};
> +	};
> +	gpio_fan {
> +		pinctrl-0 = <&pmx_fan_32 &pmx_fan_33 &pmx_fan_34>;
> +		pinctrl-names = "default";
> +		gpios = <&gpio1 0 GPIO_ACTIVE_HIGH
> +			 &gpio1 1 GPIO_ACTIVE_HIGH
> +			 &gpio1 2 GPIO_ACTIVE_HIGH>;
> +	};
> +};
