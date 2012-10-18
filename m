From: balbi@ti.com (Felipe Balbi)
Date: Thu, 18 Oct 2012 08:49:34 +0300
Subject: [PATCH v2] arm: omap: move OMAP USB platform data to
 <linux/platform_data/omap-usb.h>
In-Reply-To: <20121017203404.GY15569@atomide.com>
References: <20121016230040.GP15569@atomide.com>
 <1350488838-6289-1-git-send-email-balbi@ti.com>
 <20121017203404.GY15569@atomide.com>
Message-ID: <20121018054934.GE11137@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 17, 2012 at 01:34:04PM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [121017 08:54]:
> > In order to make single zImage work for ARM architecture,
> > we need to make sure we don't depend on private headers.
> > 
> > Move USB platform_data to <linux/platform_data/omap-usb.h>
> > and keep only internal functions in <plat/usb.h>.
> 
> Thanks, looks like I can't make this apply against v3.7-rc1:
> 
> patching file arch/arm/plat-omap/include/plat/usb.h
> Hunk #1 FAILED at 1.
> Hunk #2 FAILED at 26.
> Hunk #3 FAILED at 44.
> Hunk #4 FAILED at 65.
> Hunk #5 FAILED at 81.
> Hunk #6 succeeded at 28 with fuzz 2 (offset -128 lines).
> 5 out of 6 hunks FAILED -- rejects in file arch/arm/plat-omap/include/plat/usb.h
> 
> Can you please check it?

Are you sure you have a clean v3.7-rc1 ?

commit 9b1ebba0f43e7bf6a8fdd8aa84da65e5e0344fb7
Author: Felipe Balbi <balbi@ti.com>
Date:   Fri Sep 28 09:51:01 2012 +0300

    arm: omap: move OMAP USB platform data to <linux/platform_data/omap-usb.h>
    
    In order to make single zImage work for ARM architecture,
    we need to make sure we don't depend on private headers.
    
    Move USB platform_data to <linux/platform_data/omap-usb.h>
    and keep only internal functions in <plat/usb.h>.
    
    Signed-off-by: Felipe Balbi <balbi@ti.com>

commit ddffeb8c4d0331609ef2581d84de4d763607bd37
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Oct 14 14:41:04 2012 -0700

    Linux 3.7-rc1


That's my branch. Patch is right on top of v3.7-rc1 commit.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121018/0c4bdbcb/attachment-0001.sig>
