From: Peter.Chen@freescale.com (Peter Chen)
Date: Fri, 29 Nov 2013 08:51:27 +0000
Subject: [PATCH v2 2/2] usb: chipidea: usbmisc: Add support for i.MX51 CPU
In-Reply-To: <1385480210-9349-2-git-send-email-shc_work@mail.ru>
References: <1385480210-9349-1-git-send-email-shc_work@mail.ru>
 <1385480210-9349-2-git-send-email-shc_work@mail.ru>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A64980413AC0B@039-SN2MPN1-021.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


 
> This adds i.MX51 as the next user of the usbmisc driver.
> Functionality is similar to i.MX53, so at this stage simply
> reuse existing i.MX53 calls.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/usb/chipidea/usbmisc_imx.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/chipidea/usbmisc_imx.c
> b/drivers/usb/chipidea/usbmisc_imx.c
> index 4381c5a6..cd061ab 100644
> --- a/drivers/usb/chipidea/usbmisc_imx.c
> +++ b/drivers/usb/chipidea/usbmisc_imx.c
> @@ -204,6 +204,10 @@ static const struct of_device_id usbmisc_imx_dt_ids[]
> = {
>  		.data = &imx27_usbmisc_ops,
>  	},
>  	{
> +		.compatible = "fsl,imx51-usbmisc",
> +		.data = &imx53_usbmisc_ops,
> +	},
> +	{
>  		.compatible = "fsl,imx53-usbmisc",
>  		.data = &imx53_usbmisc_ops,
>  	},
> --

Acked-by: Peter Chen <peter.chen@freescale.com>

Peter
