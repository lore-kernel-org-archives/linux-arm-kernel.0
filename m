From: luka@openwrt.org (Luka Perkov)
Date: Thu, 19 Sep 2013 18:03:09 +0200
Subject: [PATCH] IXP4xx: Add Gateworks Cambria support.
In-Reply-To: <m3vc1ya9fw.fsf@t19.piap.pl>
References: <m3vc1ya9fw.fsf@t19.piap.pl>
Message-ID: <20130919160309-31798@mutt-kz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

it's great that you have decided to push upstream support for this
board.

I was unable to bring up serial console with your patch. I was using
latest OpenWrt trunk for rootfs, did you use the same?

drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
IP-Config: Failed to open eth0
IP-Config: Failed to open eth1
IP-Config: No network devices available
Warning: unable to open an initial console.
Freeing unused kernel memory: 4124K (c0427000 - c082e000)
procd: Console is alive

On Wed, Sep 18, 2013 at 09:13:55AM +0200, Krzysztof Ha?asa wrote:
> --- /dev/null
> +++ b/arch/arm/mach-ixp4xx/cambria.c
> @@ -0,0 +1,245 @@
> +/*
> + * Gateworks Cambria GW2350 platform support
> + * Portions based on OpenWRT.
> + */

I'm no expert on licenses but shouldn't here at least be GPLv2 since the
file originated from OpenWrt support for this board which is GPLv2.

> +static struct i2c_board_info __initdata cambria_i2c_board_info[] = {
> +	{
> +		I2C_BOARD_INFO("ad7418", 0x28),
> +	},
> +	{
> +		I2C_BOARD_INFO("24c08", 0x50),
> +		.platform_data	= &cambria_eeprom_info,
> +	},
> +};

I couldn't test this because of the console issue but in OpenWrt sources
the value is 0x51 and not 0x50. Did you change it by accident?

Also, shouldn't arch/arm/configs/ixp4xx_defconfig be updated too?

Luka
