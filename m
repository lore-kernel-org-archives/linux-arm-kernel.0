From: daniel@caiaq.de (Daniel Mack)
Date: Sat, 1 May 2010 14:21:10 +0200
Subject: [PATCHv10 2.6.34-rc6 4/5] mxc: Add generic USB HW
	initialization for MX51
In-Reply-To: <1272660507-5917-4-git-send-email-Dinh.Nguyen@freescale.com>
References: <1272660507-5917-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1272660507-5917-2-git-send-email-Dinh.Nguyen@freescale.com>
	<1272660507-5917-3-git-send-email-Dinh.Nguyen@freescale.com>
	<1272660507-5917-4-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <20100501122110.GC30801@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 30, 2010 at 03:48:26PM -0500, Dinh.Nguyen at freescale.com wrote:

[...]

> diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
> index ead59f4..544ccfd 100644
> --- a/drivers/usb/host/ehci-mxc.c
> +++ b/drivers/usb/host/ehci-mxc.c
> @@ -199,8 +199,8 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
>  	writel(pdata->portsc, hcd->regs + PORTSC_OFFSET);
>  	mdelay(10);
>  
> -	/* setup USBCONTROL. */
> -	ret = mxc_set_usbcontrol(pdev->id, pdata->flags);
> +	/* setup specific usb hw */
> +	ret = mxc_initialize_usb_hw(pdev->id, pdata->flags);
>  	if (ret < 0)
>  		goto err_init;

Ok - now we shouldn't have any possible regression.

Thanks,
Daniel
