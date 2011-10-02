From: balbi@ti.com (Felipe Balbi)
Date: Sun, 2 Oct 2011 21:59:54 +0300
Subject: [PATCH 16/30] usb/musb: HDRC depends on TWL4030_CORE for OMAP3/4
In-Reply-To: <1317566760-25681-17-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-17-git-send-email-arnd@arndb.de>
Message-ID: <20111002185953.GB25690@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Oct 02, 2011 at 04:45:46PM +0200, Arnd Bergmann wrote:
> The musb_hdrc driver tries to select TWL4030_USB or TWL6030_USB
> on some platforms, but those symbols in turn depend on TWL4030_CORE.

the very fact that MUSB tries to select those is wrong. That's also some
buggy legacy crap which is still floating around...

MUSB does not depend on TWL4030. MUSB depends on a PHY being available,
no matter which one.

IMHO, this would be better moved to board definition, ideally with an
option for selecting some symbol as module (as I have suggested before).

Ideally, all those broken dependencies on MUSB would be cut down to
depends on USB && USB_GADGET.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111002/2bbe1108/attachment.sig>
