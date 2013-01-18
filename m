From: rogerq@ti.com (Roger Quadros)
Date: Fri, 18 Jan 2013 14:36:27 +0200
Subject: [PATCH v8 01/22] USB: ehci-omap: Don't free gpios that we didn't
 request
In-Reply-To: <1358511445-26656-2-git-send-email-rogerq@ti.com>
References: <1358511445-26656-1-git-send-email-rogerq@ti.com>
 <1358511445-26656-2-git-send-email-rogerq@ti.com>
Message-ID: <50F941CB.1080808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2013 02:17 PM, Roger Quadros wrote:
> This driver does not request any gpios so don't free them.
> Fixes L3 bus error on multiple modprobe/rmmod of ehci_hcd
> with ehci-omap in use.
> 
> Without this patch, EHCI will break on repeated insmod/rmmod
> of ehci_hcd for all OMAP2+ platforms that use EHCI and
> set 'phy_reset = true' in usbhs_omap_board_data.
> i.e.
> 
> board-3430sdp.c:	.phy_reset  = true,
> board-3630sdp.c:	.phy_reset  = true,
> board-am3517crane.c:	.phy_reset  = true,
> board-am3517evm.c:	.phy_reset  = true,
> board-cm-t3517.c:	.phy_reset  = true,
> board-cm-t35.c:	.phy_reset  = true,
> board-devkit8000.c:	.phy_reset  = true,
> board-igep0020.c:	.phy_reset = true,
> board-igep0020.c:	.phy_reset = true,
> board-omap3beagle.c:	.phy_reset  = true,
> board-omap3evm.c:	.phy_reset  = true,
> board-omap3pandora.c:	.phy_reset  = true,
> board-omap3stalker.c:	.phy_reset = true,
> board-omap3touchbook.c:	.phy_reset  = true,
> board-omap4panda.c:	.phy_reset  = false,
> board-overo.c:	.phy_reset  = true,
> board-zoom.c:	.phy_reset		= true,
> 
> CC: Alan Stern <stern@rowland.harvard.edu>
> Cc: stable at kernel.org

I messed up with the stable list id, so will resend just this one
and update the git repo.

> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

cheers,
-roger
