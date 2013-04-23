From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 23 Apr 2013 10:17:34 -0700
Subject: [PATCH 19/21] usb: phy: don't mark usb_bind_phy as __init
In-Reply-To: <1366734653-488286-20-git-send-email-arnd@arndb.de>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
 <1366734653-488286-20-git-send-email-arnd@arndb.de>
Message-ID: <20130423171734.GA31432@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 06:30:51PM +0200, Arnd Bergmann wrote:
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
>  drivers/usb/otg/otg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

What tree has this file?  It's not mine :(
