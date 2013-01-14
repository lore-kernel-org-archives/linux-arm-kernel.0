From: balbi@ti.com (Felipe Balbi)
Date: Mon, 14 Jan 2013 12:16:42 +0200
Subject: [PATCH v3 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
In-Reply-To: <1358158361-25550-2-git-send-email-peter.chen@freescale.com>
References: <1358158361-25550-1-git-send-email-peter.chen@freescale.com>
 <1358158361-25550-2-git-send-email-peter.chen@freescale.com>
Message-ID: <20130114101642.GB10874@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 14, 2013 at 06:12:39PM +0800, Peter Chen wrote:
> @@ -2756,22 +2753,41 @@ static int fsl_udc_otg_resume(struct device *dev)
>  
>  	return fsl_udc_resume(NULL);
>  }
> -
>  /*-------------------------------------------------------------------------
>  	Register entry point for the peripheral controller driver
>  --------------------------------------------------------------------------*/
> -
> +static const struct platform_device_id fsl_udc_devtype[] = {
> +	{
> +		.name = "imx-udc-mx25",
> +		.driver_data = IMX25_UDC,
> +	}, {
> +		.name = "imx-udc-mx27",
> +		.driver_data = IMX27_UDC,
> +	}, {
> +		.name = "imx-udc-mx31",
> +		.driver_data = IMX31_UDC,
> +	}, {
> +		.name = "imx-udc-mx35",
> +		.driver_data = IMX35_UDC,
> +	}, {
> +		.name = "imx-udc-mx51",
> +		.driver_data = IMX51_UDC,
> +	}
> +};

I wonder if your driver-data is actually needed since you can use string
comparisson to achieve the exact same outcome.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130114/b57b5c4d/attachment.sig>
