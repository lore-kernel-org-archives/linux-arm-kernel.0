From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 14 Jan 2013 11:18:53 +0100
Subject: [PATCH v3 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
In-Reply-To: <20130114101642.GB10874@arwen.pp.htv.fi>
References: <1358158361-25550-1-git-send-email-peter.chen@freescale.com>
 <1358158361-25550-2-git-send-email-peter.chen@freescale.com>
 <20130114101642.GB10874@arwen.pp.htv.fi>
Message-ID: <50F3DB8D.6050104@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/2013 11:16 AM, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Jan 14, 2013 at 06:12:39PM +0800, Peter Chen wrote:
>> @@ -2756,22 +2753,41 @@ static int fsl_udc_otg_resume(struct device *dev)
>>  
>>  	return fsl_udc_resume(NULL);
>>  }
>> -
>>  /*-------------------------------------------------------------------------
>>  	Register entry point for the peripheral controller driver
>>  --------------------------------------------------------------------------*/
>> -
>> +static const struct platform_device_id fsl_udc_devtype[] = {
>> +	{
>> +		.name = "imx-udc-mx25",
>> +		.driver_data = IMX25_UDC,
>> +	}, {
>> +		.name = "imx-udc-mx27",
>> +		.driver_data = IMX27_UDC,
>> +	}, {
>> +		.name = "imx-udc-mx31",
>> +		.driver_data = IMX31_UDC,
>> +	}, {
>> +		.name = "imx-udc-mx35",
>> +		.driver_data = IMX35_UDC,
>> +	}, {
>> +		.name = "imx-udc-mx51",
>> +		.driver_data = IMX51_UDC,
>> +	}
>> +};
> 
> I wonder if your driver-data is actually needed since you can use string
> comparisson to achieve the exact same outcome.

Why use a string compare, if the kernel infrastructure already does this
for you?

Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130114/557b9063/attachment.sig>
