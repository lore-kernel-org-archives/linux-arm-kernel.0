From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 Jan 2013 14:49:54 -0800
Subject: [PATCH 6/8] ARM: OMAP2+: Disable code that currently does not
 work with multiplaform
In-Reply-To: <2770938.Qr8SHcYrK2@avalon>
References: <20121219192354.22098.33408.stgit@muffinssi.local>
 <20121219192627.22098.10760.stgit@muffinssi.local>
 <20130103201521.GI25633@atomide.com> <2770938.Qr8SHcYrK2@avalon>
Message-ID: <20130103224954.GJ25633@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [130103 13:25]:
> Hi Tony,
> 
> On Thursday 03 January 2013 12:15:21 Tony Lindgren wrote:
> > Hi all,
> > 
> > Looks like we need to also disable mailbox to avoid dependencies to
> > the mailbox series as it's being moved to live under drivers.
> > 
> > And we need to disable omap3isp as it tries to use the now private
> > include <plat/*.h> headers.
> 
> I've posted a patch to the linux-media mailing list to remove plat/*.h headers 
> that are not present anymore in v3.8. It will be pushed to v3.8, as this 
> breaks compilation of the driver.

Great, thanks for doing that.
 
> The driver still includes the plat/cpu.h header that can be removed as well. 
> I've just posted a patch that remove the header and will push it to v3.9. The 
> OMAP3 ISP part of this patch can thus be dropped.

OK. I suggest you merge the plat/cpu.h during the -rc cycle as well.
With v3.8-rc2 plat/cpu.h no longer contains anything for omap2+, and
we could make it now to do #error for omap2+ if the current users
are fixed.

Will drop the omap3isp part from this patch as you suggested though.

Regards,

Tony
