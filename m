From: balbi@ti.com (Felipe Balbi)
Date: Mon, 23 Dec 2013 10:25:57 -0600
Subject: [PATCH v8 3/9] usb: gadget: s3c-hsotg: enable build for other
 platforms
In-Reply-To: <1387462990-12039-4-git-send-email-mporter@linaro.org>
References: <1387462990-12039-1-git-send-email-mporter@linaro.org>
 <1387462990-12039-4-git-send-email-mporter@linaro.org>
Message-ID: <20131223162557.GC28679@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 09:23:04AM -0500, Matt Porter wrote:
> Remove unused Samsung-specific machine include and Kconfig
> dependency on S3C.
> 
> Signed-off-by: Matt Porter <mporter@linaro.org>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
> ---
>  drivers/usb/gadget/Kconfig     | 7 +++----
>  drivers/usb/gadget/s3c-hsotg.c | 2 --
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index a91e642..181e760 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -294,11 +294,10 @@ config USB_PXA27X
>  	   gadget drivers to also be dynamically linked.
>  
>  config USB_S3C_HSOTG
> -	tristate "S3C HS/OtG USB Device controller"
> -	depends on S3C_DEV_USB_HSOTG
> +	tristate "Designware/S3C HS/OtG USB Device controller"

causes build failure in x86. Sorry dropping from my queue.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131223/111b97d4/attachment.sig>
