From: balbi@ti.com (Felipe Balbi)
Date: Tue, 23 Apr 2013 22:30:46 +0300
Subject: [PATCH v2] usb: phy: don't mark usb_bind_phy as __init
In-Reply-To: <201304232107.22084.arnd@arndb.de>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
 <1366734653-488286-20-git-send-email-arnd@arndb.de>
 <20130423171734.GA31432@kroah.com>
 <201304232107.22084.arnd@arndb.de>
Message-ID: <20130423193046.GC13453@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 09:07:21PM +0200, Arnd Bergmann wrote:
> It makes no sense for a symbol to be both exported and marked __init,
> because any users in modules would be calling this function after
> it gets discarded. Further, this patch revolves a section mismatch
> warning from usbhs_init_phys(), which is intentionally not marked
> __init:
> 
> WARNING: vmlinux.o(.text+0x413f8): Section mismatch in reference from
> the function usbhs_init_phys() to the function .init.text:usb_bind_phy()
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb at vger.kernel.org
> ---
> 
> v2: rebased on linux-next

not needed, Greg already has a patch doing exactly this in usb-next.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130423/a005dd4f/attachment.sig>
