From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 11 May 2016 19:57:28 +0200
Subject: [PATCH v5 3/4] ARM: dts: meson8b: Add MMC nodes
In-Reply-To: <1456596108-1406-4-git-send-email-carlo@caione.org> (Carlo
 Caione's message of "Sat, 27 Feb 2016 19:01:47 +0100")
References: <1456596108-1406-1-git-send-email-carlo@caione.org>
 <1456596108-1406-4-git-send-email-carlo@caione.org>
Message-ID: <m24ma47a0n.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Carlo,

Carlo Caione <carlo@caione.org> writes:

> From: Carlo Caione <carlo@endlessm.com>
>
> Enable the MMC for the Meson8b platforms.
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>

[...]

> diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
> index 8bad557..25d795c 100644
> --- a/arch/arm/boot/dts/meson8b.dtsi
> +++ b/arch/arm/boot/dts/meson8b.dtsi
> @@ -187,6 +187,22 @@
>  					function = "uart_ao";
>  				};
>  			};
> +
> +			mmc0_sd_b_pins: mmc0_sd_b {
> +				mux {
> +					groups = "sd_d1_b", "sd_d0_b", "sd_clk_b", "sd_cmd_b",
> +						 "sd_d3_b", "sd_d2_b";
> +					function = "sd_b";
> +				};
> +			};

These pins are added under pinctrl_aobus, but in the pinctrl driver,
they're under cbus.  If I move this into the pinctrl_cbus node, I get it
to work on my odroid-c1, and am able to mount/use an MMC rootfs.

Kevin
