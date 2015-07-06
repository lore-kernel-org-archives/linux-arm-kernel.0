From: balbi@ti.com (Felipe Balbi)
Date: Mon, 6 Jul 2015 13:54:49 -0500
Subject: [PATCH v5 1/3] musb: sunxi: Add support for the Allwinner sunxi
 musb controller
In-Reply-To: <1434199330-22263-2-git-send-email-hdegoede@redhat.com>
References: <1434199330-22263-1-git-send-email-hdegoede@redhat.com>
 <1434199330-22263-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20150706185449.GL20779@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 13, 2015 at 02:42:08PM +0200, Hans de Goede wrote:
> This is based on initial code to get the Allwinner sunxi musb controller
> supported by Chen-Yu Tsai and Roman Byshko.
> 
> This adds support for the Allwinner sunxi musb controller in both host only
> and otg mode. Peripheral only mode is not supported, as no boards use that.
> 
> This has been tested on a cubietruck (A20 SoC) and an UTOO P66 tablet
> (A13 SoC) with a variety of devices in host mode and with the g_serial gadget
> driver in peripheral mode, plugging otg / host cables in/out a lot of times
> in all possible imaginable plug orders.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Move polling of id and vbus-det gpio-s to the phy driver
> -Use extcon to get id (USB_HOST mode) status changes from the phy driver
> -Stop using syscon, instead use Maxime Ripard's sunxi SRAM controller driver
> Changes in v3:
> -Check that USB_MUSB_FOO config is compatible with the dr_mode setting from dt
> Changes in v4:
> -Squash in "musb: sunxi: Add pre/post root reset end platform functions" patch
> -Adjust for sunxi_sram controller driver changes
> -Stop musb work from turning vbus off again when in host mode
> Changes in v5:
> -Squash in "musb: sunxi: Remove special MUSB_SUN4I flag" patch, as it was
>  mostly revering changes done by this patch
> -Adjust for extcon api changes landing in 4.2

drivers/usb/musb/sunxi.c:75:13: warning: symbol 'sunxi_musb' was not declared. Should it be static?
drivers/usb/musb/sunxi.c:151:6: warning: symbol 'sunxi_musb_pre_root_reset_end' was not declared. Should it be static?
drivers/usb/musb/sunxi.c:158:6: warning: symbol 'sunxi_musb_post_root_reset_end' was not declared. Should it be static?

please fix.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150706/c2e85a6c/attachment.sig>
