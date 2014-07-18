From: balbi@ti.com (Felipe Balbi)
Date: Fri, 18 Jul 2014 08:50:55 -0500
Subject: [PATCH 5/9] usb: musb: print error message with dev_err()
 instead of dev_dbg()
In-Reply-To: <1405675890-8802-6-git-send-email-LW@KARO-electronics.de>
References: <1405675890-8802-1-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-2-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-3-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-4-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-5-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-6-git-send-email-LW@KARO-electronics.de>
Message-ID: <20140718135055.GE24914@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 11:31:26AM +0200, Lothar Wa?mann wrote:
> 

no commit log. Not a bug fix.

> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  drivers/usb/musb/musb_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 8623112..f867b44 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -1878,7 +1878,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
>  	 * Fail when the board needs a feature that's not enabled.
>  	 */
>  	if (!plat) {
> -		dev_dbg(dev, "no platform_data?\n");
> +		dev_err(dev, "no platform_data?\n");
>  		status = -ENODEV;
>  		goto fail0;
>  	}
> -- 
> 1.7.10.4
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140718/15fda351/attachment.sig>
