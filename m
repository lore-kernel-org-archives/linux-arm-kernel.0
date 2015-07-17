From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 17 Jul 2015 11:04:28 +0200
Subject: [PATCH 7/7] mtd: atmel-quadspi: add driver for Atmel QSPI
 controller
In-Reply-To: <cf2522fc858b72af78d057ac76c4f029e80edf4a.1437059658.git.cyrille.pitchen@atmel.com>
References: <cover.1437059658.git.cyrille.pitchen@atmel.com>
 <cf2522fc858b72af78d057ac76c4f029e80edf4a.1437059658.git.cyrille.pitchen@atmel.com>
Message-ID: <1437123868.24981.7.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On do, 2015-07-16 at 17:27 +0200, Cyrille Pitchen wrote:
> --- /dev/null
> +++ b/drivers/mtd/spi-nor/atmel-quadspi.c

> +static struct platform_driver atmel_qspi_driver = {
> +	.driver		= {
> +		[...]
> +		.bus	= &platform_bus_type,
> +		[...]
> +};
> +module_platform_driver(atmel_qspi_driver);

Nit: on module init this will basically do
    __platform_driver_register(&atmel_qspi_driver, THIS_MODULE);

which will again set bus to &platform_bus_type. So you might as well
drop that line.


Paul Bolle
