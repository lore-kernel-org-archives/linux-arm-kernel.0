From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 24 Jan 2015 23:08 +0100
Subject: [PATCH 0/4] Drop legacy support for omap3517
In-Reply-To: <201501241300.00723@pali>
References: <1421171865-5209-1-git-send-email-tony@atomide.com>
 <20150115142536.GC512@earth.universe> <201501241300.00723@pali>
Message-ID: <2871852.qm0MoZvdlF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 24 January 2015 13:00:00 Pali Roh?r wrote:
> 
> Another regression for DT setup (which does not occur for board code):
> 
> omap_hsmmc driver does not export slot_name sysfs entry because
> it not supported by DT yet. Entry slot_name is used by userspace
> application to determinate if mmc block device is internal eMMC
> memory or external uSD card. So support for this property also in
> DT is needed.
> 
> Here is simple patch which fix this problem:
> 

The sysfs file only exists for the two OMAP drivers, and the naming
is used only by board-n8x0, board-rx51 and board-omap3logic.

It may be better to add a board-specific hack for these to keep the
existing user space working but not spread the use of this file anywhere
else.

	Arnd
