From: balbi@ti.com (Felipe Balbi)
Date: Thu, 15 May 2014 18:12:30 -0500
Subject: [PATCH] ARM: OMAP: replace checks for CONFIG_USB_GADGET_OMAP
In-Reply-To: <1400187345.11786.28.camel@x220>
References: <1400187345.11786.28.camel@x220>
Message-ID: <20140515231229.GA25523@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 10:55:45PM +0200, Paul Bolle wrote:
> Commit 193ab2a60700 ("usb: gadget: allow multiple gadgets to be built")
> apparently required that checks for CONFIG_USB_GADGET_OMAP would be
> replaced with checks for CONFIG_USB_OMAP. Do so now for the remaining
> checks for CONFIG_USB_GADGET_OMAP, even though these checks have
> basically been broken since v3.1.
> 
> Fixes: 193ab2a60700 ("usb: gadget: allow multiple gadgets to be built")
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Also untested.
> 
> It seems efficient to also include the change to phy-isp1301-omap.c in
> this patch (ie, not ship that as a separate patch).
> 
>  arch/arm/mach-omap1/board-h2.c        | 2 +-
>  arch/arm/mach-omap1/board-h3.c        | 2 +-
>  arch/arm/mach-omap1/board-innovator.c | 2 +-
>  arch/arm/mach-omap1/board-osk.c       | 2 +-
>  drivers/usb/phy/phy-isp1301-omap.c    | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
> index 65d2acb31498..57092bc7f4f1 100644
> --- a/arch/arm/mach-omap1/board-h2.c
> +++ b/arch/arm/mach-omap1/board-h2.c
> @@ -346,7 +346,7 @@ static struct omap_usb_config h2_usb_config __initdata = {
>  	/* usb1 has a Mini-AB port and external isp1301 transceiver */
>  	.otg		= 2,
>  
> -#ifdef	CONFIG_USB_GADGET_OMAP
> +#ifdef	CONFIG_USB_OMAP

CONFIG_USB_OMAP is tristate, it might be better to use
IS_ENABLED(CONFIG_USB_OMAP) here. Likewise for the rest of the patch.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140515/c7af7322/attachment.sig>
