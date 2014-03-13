From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 13 Mar 2014 17:14:50 +0000
Subject: [PATCH 3/3] spi: psdev: add passive serial driver
In-Reply-To: <1394639617-26917-4-git-send-email-m.grzeschik@pengutronix.de>
References: <1394639617-26917-1-git-send-email-m.grzeschik@pengutronix.de>
 <1394639617-26917-4-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <20140313171450.GA25870@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 03:53:37PM +0000, Michael Grzeschik wrote:
> This patch introduces the psdev driver. It is used to communicate to an
> Altera passive serial connected FPGA by writing into an character
> device.
> 
> It simply initates the protocol on open and clocks the data into the
> FPGA by using the underlying SPI bus on write. The used SPI bus can also
> be an bitbang SPI bus. On close it will check for the response of the
> FPGA and tells if the write process was successful.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  drivers/spi/Kconfig    |   9 +
>  drivers/spi/Makefile   |   1 +
>  drivers/spi/spipsdev.c | 520 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 530 insertions(+)
>  create mode 100644 drivers/spi/spipsdev.c

[...]

> +static const struct of_device_id psdev_dt_ids[] = {
> +       { .compatible = "altr,passive-serial" },
> +       {},
> +};

There should be a binding document for this as part of the series.

Thanks,
Mark.
