From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Jul 2016 17:33:52 +0200
Subject: [PATCH v4] ARM: dts: sun8i: Add dts file for Olimex A33-OLinuXino
In-Reply-To: <1469450243-19138-1-git-send-email-stefan.mavrodiev@gmail.com>
References: <1469450243-19138-1-git-send-email-stefan.mavrodiev@gmail.com>
Message-ID: <20160726153352.GH7190@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Mon, Jul 25, 2016 at 03:37:23PM +0300, Stefan Mavrodiev wrote:
> A33-OLinuXino is A33 development board designed by Olimex LTD.
> 
> It has AXP233 PMU, 1GB DRAM, a micro SD card, one USB-OTG connector,
> headphone and mic jacks, connector for LiPo battery and optional
> 4GB NAND Flash.
> 
> It has two 40-pin headers. One for LCD panel, and one for
> additional modules. Also there is CSI/DSI connector.
> 
> Signed-off-by: Stefan Mavrodiev <stefan.mavrodiev@gmail.com>

It looks mostly good, a few comments though.
> +&pio {
> +	led_pin_olinuxino: led_pins at 0 {
> +		allwinner,pins = "PB7";
> +        allwinner,function = "gpio_out";

This line is not properly indented.

> +		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +    };

And this one too.

> +&reg_dc1sw {
> +	regulator-name = "vcc-lcd";
> +};

No constraints on this one?

> +&reg_dcdc1 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <3300000>;
> +	regulator-max-microvolt = <3300000>;
> +	regulator-name = "vcc-dsi";
> +};

What is it used for? Is it really necessary to keep it on at all time?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160726/6a3e3915/attachment.sig>
