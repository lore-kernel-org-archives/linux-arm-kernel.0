From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Sat, 24 Jan 2015 23:14:58 +0100
Subject: [PATCH 0/4] Drop legacy support for omap3517
In-Reply-To: <2871852.qm0MoZvdlF@wuerfel>
References: <1421171865-5209-1-git-send-email-tony@atomide.com>
 <201501241300.00723@pali> <2871852.qm0MoZvdlF@wuerfel>
Message-ID: <201501242314.58201@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 24 January 2015 23:08:00 Arnd Bergmann wrote:
> On Saturday 24 January 2015 13:00:00 Pali Roh?r wrote:
> > Another regression for DT setup (which does not occur for
> > board code):
> > 
> > omap_hsmmc driver does not export slot_name sysfs entry
> > because it not supported by DT yet. Entry slot_name is used
> > by userspace application to determinate if mmc block device
> > is internal eMMC memory or external uSD card. So support
> > for this property also in DT is needed.
> 
> > Here is simple patch which fix this problem:
> The sysfs file only exists for the two OMAP drivers, and the
> naming is used only by board-n8x0, board-rx51 and
> board-omap3logic.
> 
> It may be better to add a board-specific hack for these to
> keep the existing user space working but not spread the use
> of this file anywhere else.
> 
> 	Arnd

Why? omap_hsmmc.c has already support for slot_name sysfs entry, 
just it is not filled from DT data (only from platform_data)...

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150124/9901f95a/attachment.sig>
