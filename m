From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Mon, 20 Jul 2015 10:55:54 +0200
Subject: [PATCH 7/7] mtd: atmel-quadspi: add driver for Atmel QSPI
 controller
In-Reply-To: <1437123868.24981.7.camel@tiscali.nl>
References: <cover.1437059658.git.cyrille.pitchen@atmel.com>	
 <cf2522fc858b72af78d057ac76c4f029e80edf4a.1437059658.git.cyrille.pitchen@atmel.com>
 <1437123868.24981.7.camel@tiscali.nl>
Message-ID: <55ACB79A.3010101@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

I've removed the ".bus = &plaform_bus_type" for the next series.
Thank you for the explanation and the review :)

Best Regards,

Cyrille

Le 17/07/2015 11:04, Paul Bolle a ?crit :
> On do, 2015-07-16 at 17:27 +0200, Cyrille Pitchen wrote:
>> --- /dev/null
>> +++ b/drivers/mtd/spi-nor/atmel-quadspi.c
> 
>> +static struct platform_driver atmel_qspi_driver = {
>> +	.driver		= {
>> +		[...]
>> +		.bus	= &platform_bus_type,
>> +		[...]
>> +};
>> +module_platform_driver(atmel_qspi_driver);
> 
> Nit: on module init this will basically do
>     __platform_driver_register(&atmel_qspi_driver, THIS_MODULE);
> 
> which will again set bus to &platform_bus_type. So you might as well
> drop that line.
> 
> 
> Paul Bolle
> 
