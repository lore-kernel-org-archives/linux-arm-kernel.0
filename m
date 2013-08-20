From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 20 Aug 2013 21:57:24 +0400
Subject: [PATCH v5 5/8] usb: musb: omap2430: Don't use
 omap_get_control_dev()
In-Reply-To: <1377010577-19355-6-git-send-email-rogerq@ti.com>
References: <1377010577-19355-1-git-send-email-rogerq@ti.com>
 <1377010577-19355-6-git-send-email-rogerq@ti.com>
Message-ID: <5213AE04.1070907@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08/20/2013 06:56 PM, Roger Quadros wrote:

> omap_get_control_dev() is being deprecated as it doesn't support
> multiple instances. As control device is present only from OMAP4
> onwards which supports DT only, we use phandles to get the
> reference to the control device.

> Also get rid of "ti,has-mailbox" property as it is redundant and
> we can determine that from whether "ctrl-module" property is present
> or not. Get rid of has_mailbox from musb_hdrc_platform_data as well.

> Signed-off-by: Roger Quadros <rogerq@ti.com>
[...]

> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index ebb46ec..516795b 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
[...]
> @@ -509,8 +510,12 @@ static int omap2430_probe(struct platform_device *pdev)
>   	glue->dev			= &pdev->dev;
>   	glue->musb			= musb;
>   	glue->status			= OMAP_MUSB_UNKNOWN;
> +	glue->control_otghs = ERR_PTR(-ENODEV);

    Could you please align = with the others above?

WBR, Sergei
