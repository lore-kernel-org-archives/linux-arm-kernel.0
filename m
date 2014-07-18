From: balbi@ti.com (Felipe Balbi)
Date: Fri, 18 Jul 2014 08:45:57 -0500
Subject: [PATCH 3/9] usb: musb_am335x: source cleanup
In-Reply-To: <1405675890-8802-4-git-send-email-LW@KARO-electronics.de>
References: <1405675890-8802-1-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-2-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-3-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-4-git-send-email-LW@KARO-electronics.de>
Message-ID: <20140718134557.GC24914@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 11:31:24AM +0200, Lothar Wa?mann wrote:
> - remove comma after end of list delimiter
>   The empty entry must always be the last item in the list, thus there
>   is no point in having a trailing comma to facilitate adding
>   succeding entries.
>   Remove the comma, so that inadvertedly adding an entry after the end
>   of list sentinel will produce a compile time error rather than an
>   unreachable entry in the list.
> - consistently use tabs for indentation
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  drivers/usb/musb/musb_am335x.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_am335x.c b/drivers/usb/musb/musb_am335x.c
> index 1e58ed2..164c868 100644
> --- a/drivers/usb/musb/musb_am335x.c
> +++ b/drivers/usb/musb/musb_am335x.c
> @@ -21,14 +21,14 @@ err:
>  
>  static const struct of_device_id am335x_child_of_match[] = {
>  	{ .compatible = "ti,am33xx-usb" },
> -	{  },
> +	{  }

makes not difference, but fine.

>  };
>  MODULE_DEVICE_TABLE(of, am335x_child_of_match);
>  
>  static struct platform_driver am335x_child_driver = {
>  	.probe		= am335x_child_probe,
> -	.driver         = {
> -		.name   = "am335x-usb-childs",
> +	.driver		= {
> +		.name	= "am335x-usb-childs",

thanks, still not a bug fix.

>  		.of_match_table	= am335x_child_of_match,
>  	},
>  };
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140718/d650a9f3/attachment.sig>
