From: balbi@ti.com (Felipe Balbi)
Date: Wed, 18 Dec 2013 10:07:36 -0600
Subject: [RFC 4/5] usb: dwc3-exynos: enable async suspend/resume
In-Reply-To: <1387363174-25942-4-git-send-email-yuvaraj.cd@samsung.com>
References: <1387363174-25942-1-git-send-email-yuvaraj.cd@samsung.com>
 <1387363174-25942-4-git-send-email-yuvaraj.cd@samsung.com>
Message-ID: <20131218160736.GD4970@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 04:09:33PM +0530, Yuvaraj Kumar C D wrote:
> From: Andrew Bresticker <abrestic@chromium.org>
> 
> In addition to enabling async suspend/resume on the xhci-plat device,
> we must enable it for the dwc3-exynos platform device in order to make
> the full USB stack resume asynchronously.  Like the xhci-plat, ehci-s5p,
> and ohci-exynos drivers, there are no outside dependencies which would
> make resuming the dwc3-exynos driver asynchronously unsafe.
> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Reviewed-by: Julius Werner <jwerner@chromium.org>
> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> ---
>  drivers/usb/dwc3/dwc3-exynos.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
> index 8b20c70..57431b7 100644
> --- a/drivers/usb/dwc3/dwc3-exynos.c
> +++ b/drivers/usb/dwc3/dwc3-exynos.c
> @@ -155,6 +155,8 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>  		goto err2;
>  	}
>  
> +	device_enable_async_suspend(dev);

sure that clk_disable() in your ->suspend() callback will cause no
issues at all ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131218/b86fbf0e/attachment.sig>
