From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 08 Sep 2016 11:08:07 -0700
Subject: [PATCH 1/7] pinctrl: amlogic: gxbb: add spifc pins
In-Reply-To: <1473261223-15412-2-git-send-email-jbrunet@baylibre.com> (Jerome
 Brunet's message of "Wed, 7 Sep 2016 17:13:37 +0200")
References: <1473261223-15412-1-git-send-email-jbrunet@baylibre.com>
 <1473261223-15412-2-git-send-email-jbrunet@baylibre.com>
Message-ID: <m2d1kenu2g.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Add EE domains pins for the SPI flash controller
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
> index cb4d6ad..802ad83 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
> @@ -156,6 +156,11 @@ static const unsigned int emmc_clk_pins[] = { PIN(BOOT_8, EE_OFF) };
>  static const unsigned int emmc_cmd_pins[] = { PIN(BOOT_10, EE_OFF) };
>  static const unsigned int emmc_ds_pins[] = { PIN(BOOT_15, EE_OFF) };
>  
> +static const unsigned int spifc_d_pins[]	= { PIN(BOOT_11, EE_OFF) };
> +static const unsigned int spifc_q_pins[]	= { PIN(BOOT_12, EE_OFF) };
> +static const unsigned int spifc_c_pins[]	= { PIN(BOOT_13, EE_OFF) };
> +static const unsigned int spifc_cs_pins[]	= { PIN(BOOT_15, EE_OFF) };

In the datasheet, these are called nor_* instead of spifc_*.  I'm trying
to keep the names here aligned with the names in the datasheet.  Please
rename to nor_*.

Thanks,

Kevin
