From: balbi@ti.com (Felipe Balbi)
Date: Mon, 14 Jan 2013 12:39:52 +0200
Subject: [PATCH v3 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
In-Reply-To: <50F3DF1D.3040706@pengutronix.de>
References: <1358158361-25550-1-git-send-email-peter.chen@freescale.com>
 <1358158361-25550-2-git-send-email-peter.chen@freescale.com>
 <20130114101642.GB10874@arwen.pp.htv.fi>
 <50F3DB8D.6050104@pengutronix.de>
 <20130114102444.GD10874@arwen.pp.htv.fi>
 <50F3DF1D.3040706@pengutronix.de>
Message-ID: <20130114103952.GF10874@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 11:34:05AM +0100, Marc Kleine-Budde wrote:
> On 01/14/2013 11:24 AM, Felipe Balbi wrote:
> > On Mon, Jan 14, 2013 at 11:18:53AM +0100, Marc Kleine-Budde wrote:
> >> On 01/14/2013 11:16 AM, Felipe Balbi wrote:
> >>> Hi,
> >>>
> >>> On Mon, Jan 14, 2013 at 06:12:39PM +0800, Peter Chen wrote:
> >>>> @@ -2756,22 +2753,41 @@ static int fsl_udc_otg_resume(struct device *dev)
> >>>>  
> >>>>  	return fsl_udc_resume(NULL);
> >>>>  }
> >>>> -
> >>>>  /*-------------------------------------------------------------------------
> >>>>  	Register entry point for the peripheral controller driver
> >>>>  --------------------------------------------------------------------------*/
> >>>> -
> >>>> +static const struct platform_device_id fsl_udc_devtype[] = {
> >>>> +	{
> >>>> +		.name = "imx-udc-mx25",
> >>>> +		.driver_data = IMX25_UDC,
> >>>> +	}, {
> >>>> +		.name = "imx-udc-mx27",
> >>>> +		.driver_data = IMX27_UDC,
> >>>> +	}, {
> >>>> +		.name = "imx-udc-mx31",
> >>>> +		.driver_data = IMX31_UDC,
> >>>> +	}, {
> >>>> +		.name = "imx-udc-mx35",
> >>>> +		.driver_data = IMX35_UDC,
> >>>> +	}, {
> >>>> +		.name = "imx-udc-mx51",
> >>>> +		.driver_data = IMX51_UDC,
> >>>> +	}
> >>>> +};
> >>>
> >>> I wonder if your driver-data is actually needed since you can use string
> >>> comparisson to achieve the exact same outcome.
> >>
> >> Why use a string compare, if the kernel infrastructure already does this
> >> for you?
> > 
> > what do you mean ? What kernel infrastructure is doing waht for me ?
> 
> The kernel infrastructure is doing the string compare for you to match
> the device against the driver (via platform_device_id->name). You get
> the a pointer to the driver_data for free. So you don't need any string
> compare in the driver later.

but current driver data is just duplicating name with an integer, it's
pretty useless driver data.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130114/f338144b/attachment.sig>
