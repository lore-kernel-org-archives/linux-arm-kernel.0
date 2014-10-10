From: balbi@ti.com (Felipe Balbi)
Date: Fri, 10 Oct 2014 12:59:58 -0500
Subject: [PATCH 05/12] rtc: omap: remove redundant debug message
In-Reply-To: <1412881594-25678-6-git-send-email-johan@kernel.org>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1412881594-25678-6-git-send-email-johan@kernel.org>
Message-ID: <20141010175958.GQ31348@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 09, 2014 at 09:06:27PM +0200, Johan Hovold wrote:
> Remove redundant debug message.
> 
> The corresponding error has already been logged by rtc core.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/rtc/rtc-omap.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index d1b5562a148b..e50ffd7063f5 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -485,11 +485,9 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
>  
>  	rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
>  			&omap_rtc_ops, THIS_MODULE);
> -	if (IS_ERR(rtc)) {
> -		pr_debug("%s: can't register RTC device, err %ld\n",
> -			pdev->name, PTR_ERR(rtc));
> +	if (IS_ERR(rtc))
>  		goto fail0;
> -	}
> +
>  	platform_set_drvdata(pdev, rtc);
>  
>  	return 0;
> -- 
> 2.0.4
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141010/063501fc/attachment.sig>
