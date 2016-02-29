From: tony@atomide.com (Tony Lindgren)
Date: Mon, 29 Feb 2016 13:51:37 -0800
Subject: [PATCH v4 1/5] ARM: dts: LG Optimus Black codename sniper basic
 support
In-Reply-To: <1456663185-14170-2-git-send-email-contact@paulk.fr>
References: <1456663185-14170-1-git-send-email-contact@paulk.fr>
 <1456663185-14170-2-git-send-email-contact@paulk.fr>
Message-ID: <20160229215136.GO13417@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Paul Kocialkowski <contact@paulk.fr> [160228 04:40]:
> The LG Optimus Black codename sniper is a smartphone that was designed and
> manufactured by LG Electronics (LGE) and released back in 2011.
> It is using an OMAP3630 SoC, GP version.
> 
> This adds devicetree support for the device, with only a few basic features
> supported, such as debug uart, i2c, internal emmc and external mmc.
...
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;
> +
> +	clock-frequency = <2600000>;
> +
> +	twl: twl at 48 {
> +		reg = <0x48>;
> +		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
> +		interrupt-parent = <&intc>;
> +
> +		power {
> +			compatible = "ti,twl4030-power";
> +			ti,use_poweroff;
> +		};
> +	};
> +};

Chances are this devices supports cutting off the voltages and
the high frequency oscillator during idle. So you may want to
at some point set compatible = "ti,twl4030-power-idle-osc-off"
here.

Anyways, applying the dts changes into omap-for-v4.6/dt thanks.

Regards,

Tony
