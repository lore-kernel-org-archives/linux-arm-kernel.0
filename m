From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 2 Sep 2010 17:02:58 +0200
Subject: [PATCH 3/6] mx5: add support to dynamically register spi_imx
	devices (imx51 3ds)
In-Reply-To: <1283413924-14210-4-git-send-email-jason77.wang@gmail.com>
References: <1283413924-14210-1-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-2-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-3-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-4-git-send-email-jason77.wang@gmail.com>
Message-ID: <20100902150258.GN14214@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Thu, Sep 02, 2010 at 03:52:01PM +0800, Jason Wang wrote:
> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
> ---
>  arch/arm/mach-mx5/Kconfig         |    1 +
>  arch/arm/mach-mx5/devices-imx51.h |   20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mx5/devices-imx51.h
> 
> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> index 0848db5..898fb47 100644
> --- a/arch/arm/mach-mx5/Kconfig
> +++ b/arch/arm/mach-mx5/Kconfig
> @@ -18,6 +18,7 @@ config MACH_MX51_BABBAGE
>  config MACH_MX51_3DS
>  	bool "Support MX51PDK (3DS)"
>  	select MXC_DEBUG_BOARD
> +	select IMX_HAVE_PLATFORM_SPI_IMX
>  	help
>  	  Include support for MX51PDK (3DS) platform. This includes specific
>  	  configurations for the board and its peripherals.
> diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
> new file mode 100644
> index 0000000..d04c7eb
> --- /dev/null
> +++ b/arch/arm/mach-mx5/devices-imx51.h
> @@ -0,0 +1,20 @@
> +/*
> + * Copyright (C) 2010 Jason Wang <jason77.wang@gmail.com>
> + *
> + * based on mach-mx3/devices-imx35.h which is
> + * Copyright (C) 2010 Pengutronix
> + * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
> + *
> + * This program is free software; you can redistribute it and/or modify it under
> + * the terms of the GNU General Public License version 2 as published by the
> + * Free Software Foundation.
> + */
> +#include <mach/mx51.h>
> +#include <mach/devices-common.h>
> +
> +#define imx51_add_spi_imx0(pdata)	\
> +	imx_add_spi_imx(0, MX51_CSPI1_BASE_ADDR, SZ_4K, MX51_MXC_INT_CSPI1, pdata)
> +#define imx51_add_spi_imx1(pdata)	\
> +	imx_add_spi_imx(1, MX51_CSPI2_BASE_ADDR, SZ_4K, MX51_MXC_INT_CSPI2, pdata)
> +#define imx51_add_spi_imx2(pdata)	\
> +	imx_add_spi_imx(1, MX51_CSPI3_BASE_ADDR, SZ_4K, MX51_MXC_INT_CSPI, pdata)
I like my new approach better.  See my patch 3.

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
