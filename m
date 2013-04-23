From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Apr 2013 21:46:19 +0200
Subject: [PATCH v2] usb: phy: don't mark usb_bind_phy as __init
In-Reply-To: <20130423193046.GC13453@arwen.pp.htv.fi>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
 <201304232107.22084.arnd@arndb.de> <20130423193046.GC13453@arwen.pp.htv.fi>
Message-ID: <201304232146.20011.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 April 2013, Felipe Balbi wrote:
> On Tue, Apr 23, 2013 at 09:07:21PM +0200, Arnd Bergmann wrote:
> > It makes no sense for a symbol to be both exported and marked __init,
> > because any users in modules would be calling this function after
> > it gets discarded. Further, this patch revolves a section mismatch
> > warning from usbhs_init_phys(), which is intentionally not marked
> > __init:
> > 
> > WARNING: vmlinux.o(.text+0x413f8): Section mismatch in reference from
> > the function usbhs_init_phys() to the function .init.text:usb_bind_phy()
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-usb at vger.kernel.org
> > ---
> > 
> > v2: rebased on linux-next
> 
> not needed, Greg already has a patch doing exactly this in usb-next.

Right, I see it now. I had checked today's linux-next but not usb-next
or any of the other trees for stuff that was just applied today.

	Arnd
