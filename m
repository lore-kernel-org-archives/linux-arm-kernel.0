From: balbi@ti.com (Felipe Balbi)
Date: Tue, 5 Feb 2013 11:24:45 +0200
Subject: [PATCH 07/30] mfd: omap-usb-host: update nports in platform_data
In-Reply-To: <1359372631-8180-8-git-send-email-rogerq@ti.com>
References: <1359372631-8180-1-git-send-email-rogerq@ti.com>
 <1359372631-8180-8-git-send-email-rogerq@ti.com>
Message-ID: <20130205092444.GP32118@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 01:30:08PM +0200, Roger Quadros wrote:
> EHCI driver would need to know the number of ports available
> on the platform. We set the nports parameter of platform_data
> based on IP version if it was not already provided.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/mfd/omap-usb-host.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 6b5edf6..0874352 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -575,6 +575,7 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>  			 omap->usbhs_rev, omap->nports);
>  			break;
>  		}
> +		pdata->nports = omap->nports;
>  	}
>  
>  	i = sizeof(struct clk *) * omap->nports;
> -- 
> 1.7.4.1
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130205/d0b5368f/attachment.sig>
