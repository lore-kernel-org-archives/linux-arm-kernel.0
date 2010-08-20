From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 20 Aug 2010 19:10:12 +0200
Subject: [PATCH 1/2] mx35_3ds: add physmap-flash NOR at CS0
In-Reply-To: <4C6D0BEB.7080002@ru.mvista.com>
References: <1282146406-2901-1-git-send-email-m.grzeschik@pengutronix.de>
	<1282146406-2901-2-git-send-email-m.grzeschik@pengutronix.de>
	<4C6D0BEB.7080002@ru.mvista.com>
Message-ID: <20100820171012.GM27749@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Thu, Aug 19, 2010 at 02:48:11PM +0400, Sergei Shtylyov wrote:
>> +	.width  = 2,
>> +};
>> +
>> +static struct resource mx35pdk_flash_resource = {
>> +	.start	= MX35_CS0_BASE_ADDR,
>> +	.end	= MX35_CS0_BASE_ADDR + SZ_64M - 1,
>> +	.flags	= IORESOURCE_MEM,
>> +};
>> +
>> +static struct platform_device mx35pdk_flash = {
>> +	.name	= "physmap-flash",
>> +	.id	= 0,
>
>    -1 perhaps as that is probably a single physmap devie on your board?

Generally yes, but we are using command line partition tables and all
our bootloader environments pass physmap-flash.0 as identifier, so it's
better to keep 0.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
