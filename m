From: groeck@google.com (Guenter Roeck)
Date: Mon, 2 Jul 2018 07:43:30 -0700
Subject: [PATCH 3/3] Input: keyboard: Fix ChromeOS EC keyboard help
 message.
In-Reply-To: <20180702102201.13461-4-enric.balletbo@collabora.com>
References: <20180702102201.13461-1-enric.balletbo@collabora.com>
 <20180702102201.13461-4-enric.balletbo@collabora.com>
Message-ID: <CABXOdTfLS-x_sPWBi2mmjkUTtN0Spd9ObEy5fYtEB-hoLJTPEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 2, 2018 at 3:22 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> The cros-ec I2C and SPI transport drivers have been moved from MFD
> subsystem to platform/chrome, at the same time, the config symbol
> has been renamed and lost the MFD_ prefix So, update the help message
> accordingly.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
>  drivers/input/keyboard/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 6bd97ffee761..4713957b0cbb 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -721,7 +721,7 @@ config KEYBOARD_CROS_EC
>         help
>           Say Y here to enable the matrix keyboard used by ChromeOS devices
>           and implemented on the ChromeOS EC. You must enable one bus option
> -         (MFD_CROS_EC_I2C or MFD_CROS_EC_SPI) to use this.
> +         (CROS_EC_I2C or CROS_EC_SPI) to use this.
>
>           To compile this driver as a module, choose M here: the
>           module will be called cros_ec_keyb.
> --
> 2.18.0
>
