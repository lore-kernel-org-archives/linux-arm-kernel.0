From: balbi@ti.com (Felipe Balbi)
Date: Tue, 13 May 2014 10:28:29 -0500
Subject: [PATCH 6/8] usb: xhci: avoid warning for !PM_SLEEP
In-Reply-To: <1399557141-1346645-7-git-send-email-arnd@arndb.de>
References: <1399557141-1346645-1-git-send-email-arnd@arndb.de>
 <1399557141-1346645-7-git-send-email-arnd@arndb.de>
Message-ID: <20140513152829.GK1151@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 03:52:19PM +0200, Arnd Bergmann wrote:
> If we build a kernel with PM_SUSPEND set and no PM_SLEEP,
> we get a build warning in the xhci-plat driver about unused
> functions.
> 
> To fix this, use "#ifdef CONFIG_PM_SLEEP", like we do in most
> other drivers nowadays.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Mathias Nyman <mathias.nyman@intel.com>
> ---
>  drivers/usb/host/xhci-plat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 151901c..3473296 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -202,7 +202,7 @@ static int xhci_plat_remove(struct platform_device *dev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP

can we just drop the ifdeferry altogether, including from SET_*_OPS
macros ? This is just ridiculous that every merge window we have tens of
patches fixing the ifdef in several drivers.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140513/68b44c72/attachment.sig>
