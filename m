From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 4 Dec 2013 21:59:10 +0800
Subject: [PATCH v2 2/2] usb: chipidea: usbmisc: Add support for i.MX51 CPU
In-Reply-To: <1385480210-9349-2-git-send-email-shc_work@mail.ru>
References: <1385480210-9349-1-git-send-email-shc_work@mail.ru>
 <1385480210-9349-2-git-send-email-shc_work@mail.ru>
Message-ID: <20131204135909.GF1573@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 07:36:50PM +0400, Alexander Shiyan wrote:
> This adds i.MX51 as the next user of the usbmisc driver.
> Functionality is similar to i.MX53, so at this stage simply
> reuse existing i.MX53 calls.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/usb/chipidea/usbmisc_imx.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
> index 4381c5a6..cd061ab 100644
> --- a/drivers/usb/chipidea/usbmisc_imx.c
> +++ b/drivers/usb/chipidea/usbmisc_imx.c
> @@ -204,6 +204,10 @@ static const struct of_device_id usbmisc_imx_dt_ids[] = {
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
> 1.8.3.2
> 
> 

Applied, thanks.

-- 

Best Regards,
Peter Chen
