From: mathias.nyman@linux.intel.com (Mathias Nyman)
Date: Tue, 14 Mar 2017 11:20:49 +0200
Subject: [PATCH] [for 4.11]xhci: plat: Register shutdown for xhci_plat
In-Reply-To: <1489442340-27084-1-git-send-email-awallis@codeaurora.org>
References: <1489442340-27084-1-git-send-email-awallis@codeaurora.org>
Message-ID: <58C7B5F1.7070003@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.03.2017 23:59, Adam Wallis wrote:
> Shutdown should be called for xhci_plat devices especially for
> situations where kexec might be used by stopping DMA
> transactions.
>
> Signed-off-by: Adam Wallis <awallis@codeaurora.org>
> ---
>   drivers/usb/host/xhci-plat.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index bd02a6c..6ed468f 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -344,6 +344,7 @@ static int xhci_plat_resume(struct device *dev)
>   static struct platform_driver usb_xhci_driver = {
>   	.probe	= xhci_plat_probe,
>   	.remove	= xhci_plat_remove,
> +	.shutdown	= usb_hcd_platform_shutdown,

Thanks, adding to queue.

-Mathias
