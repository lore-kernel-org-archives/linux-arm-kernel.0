From: mranostay@gmail.com (Matt Ranostay)
Date: Tue, 2 Feb 2016 23:55:58 -0800
Subject: [PATCH] iio: chemical: select IRQ_WORK for ATLAS ph sensor
In-Reply-To: <5127664.OXcBoKUPQO@wuerfel>
References: <5127664.OXcBoKUPQO@wuerfel>
Message-ID: <CAKzfze8b7Q4ZHyXW=wq4K2ETFoMrfERpTci2dSAzSgCCrWpnzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Matt Ranostay <mranostay@gmail.com>

On Tue, Feb 2, 2016 at 6:36 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The newly added atlas-ph-sensor driver uses irq_work_queue, which
> may not always be enabled:
>
> ERROR: "irq_work_queue" [drivers/iio/chemical/atlas-ph-sensor.ko] undefined!
>
> This adds a 'select' statement to Kconfig to ensure it's there
> when we need it.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 27dec00ecf2d ("iio: chemical: add Atlas pH-SM sensor support")
>
> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> index ce7cd1370f74..f73290f84c90 100644
> --- a/drivers/iio/chemical/Kconfig
> +++ b/drivers/iio/chemical/Kconfig
> @@ -10,6 +10,7 @@ config ATLAS_PH_SENSOR
>         select REGMAP_I2C
>         select IIO_BUFFER
>         select IIO_TRIGGERED_BUFFER
> +       select IRQ_WORK
>         help
>          Say Y here to build I2C interface support for the Atlas
>          Scientific OEM pH-SM sensor.
>
