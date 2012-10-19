From: balbi@ti.com (Felipe Balbi)
Date: Fri, 19 Oct 2012 09:55:00 +0300
Subject: [PATCH v2] arm: omap: move OMAP USB platform data to
 <linux/platform_data/omap-usb.h>
In-Reply-To: <20121019014917.GL30550@atomide.com>
References: <20121016230040.GP15569@atomide.com>
 <1350488838-6289-1-git-send-email-balbi@ti.com>
 <20121017203404.GY15569@atomide.com>
 <20121018054934.GE11137@arwen.pp.htv.fi>
 <20121019014917.GL30550@atomide.com>
Message-ID: <20121019065500.GD12235@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 18, 2012 at 06:49:17PM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [121017 22:56]:
> > Hi,
> > 
> > On Wed, Oct 17, 2012 at 01:34:04PM -0700, Tony Lindgren wrote:
> > > * Felipe Balbi <balbi@ti.com> [121017 08:54]:
> > > > In order to make single zImage work for ARM architecture,
> > > > we need to make sure we don't depend on private headers.
> > > > 
> > > > Move USB platform_data to <linux/platform_data/omap-usb.h>
> > > > and keep only internal functions in <plat/usb.h>.
> > > 
> > > Thanks, looks like I can't make this apply against v3.7-rc1:
> > > 
> > > patching file arch/arm/plat-omap/include/plat/usb.h
> > > Hunk #1 FAILED at 1.
> > > Hunk #2 FAILED at 26.
> > > Hunk #3 FAILED at 44.
> > > Hunk #4 FAILED at 65.
> > > Hunk #5 FAILED at 81.
> > > Hunk #6 succeeded at 28 with fuzz 2 (offset -128 lines).
> > > 5 out of 6 hunks FAILED -- rejects in file arch/arm/plat-omap/include/plat/usb.h
> > > 
> > > Can you please check it?
> > 
> > Are you sure you have a clean v3.7-rc1 ?
> 
> Yes. Figured it out, it fails to apply with quilt, but applies
> with git.

probably because of file rename.

> But it does not compile with all configs though, and does
> not remove plat/usb.h. Thanks anyways. I'll post a proper
> series shortly with your patch fixed up.

ok... I'll check it out. I kept the non-static functions in plat/usb.h
because they didn't belong on platform_data/usb-omap.h. What should be
done with those, then ? move to mach/ ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121019/fc967dd3/attachment.sig>
