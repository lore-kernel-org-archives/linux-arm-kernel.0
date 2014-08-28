From: balbi@ti.com (Felipe Balbi)
Date: Thu, 28 Aug 2014 14:28:39 -0500
Subject: [PATCH 4/5] usb: dwc3: Adding Kconfig dependency for Exynos7
In-Reply-To: <1409212920-28526-5-git-send-email-gautam.vivek@samsung.com>
References: <1409212920-28526-1-git-send-email-gautam.vivek@samsung.com>
 <1409212920-28526-5-git-send-email-gautam.vivek@samsung.com>
Message-ID: <20140828192824.GR16689@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 28, 2014 at 01:31:59PM +0530, Vivek Gautam wrote:
> The Exynos-DWC3 USB 3.0 DRD controller is also present on
> Exynos7 platform, so adding the dependency on ARCH_EXYNOS7
> for this driver.
> 
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> ---
>  drivers/usb/dwc3/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index 785510a..e235894 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -55,7 +55,7 @@ config USB_DWC3_OMAP
>  
>  config USB_DWC3_EXYNOS
>  	tristate "Samsung Exynos Platform"
> -	depends on ARCH_EXYNOS || COMPILE_TEST
> +	depends on (ARCH_EXYNOS || ARCH_EXYNOS7) || COMPILE_TEST

wait when building for ARCH_EXYNOS7 you don't get ARCH_EXYNOS ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140828/623b8d20/attachment.sig>
