From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 03 Jan 2013 23:53:35 +0100
Subject: [PATCH 6/8] ARM: OMAP2+: Disable code that currently does not
 work with multiplaform
In-Reply-To: <20130103224954.GJ25633@atomide.com>
References: <20121219192354.22098.33408.stgit@muffinssi.local>
 <2770938.Qr8SHcYrK2@avalon> <20130103224954.GJ25633@atomide.com>
Message-ID: <2553128.bVQFtBdOtK@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Thursday 03 January 2013 14:49:54 Tony Lindgren wrote:
> * Laurent Pinchart <laurent.pinchart@ideasonboard.com> [130103 13:25]:
> > Hi Tony,
> > 
> > On Thursday 03 January 2013 12:15:21 Tony Lindgren wrote:
> > > Hi all,
> > > 
> > > Looks like we need to also disable mailbox to avoid dependencies to
> > > the mailbox series as it's being moved to live under drivers.
> > > 
> > > And we need to disable omap3isp as it tries to use the now private
> > > include <plat/*.h> headers.
> > 
> > I've posted a patch to the linux-media mailing list to remove plat/*.h
> > headers that are not present anymore in v3.8. It will be pushed to v3.8,
> > as this breaks compilation of the driver.
> 
> Great, thanks for doing that.
> 
> > The driver still includes the plat/cpu.h header that can be removed as
> > well. I've just posted a patch that remove the header and will push it to
> > v3.9. The OMAP3 ISP part of this patch can thus be dropped.
> 
> OK. I suggest you merge the plat/cpu.h during the -rc cycle as well.
> With v3.8-rc2 plat/cpu.h no longer contains anything for omap2+, and
> we could make it now to do #error for omap2+ if the current users
> are fixed.

If Mauro is fine with the patch going to v3.8-rc I have no issue with that. Is 
this patch targetted at v3.8 or v3.9 ?

> Will drop the omap3isp part from this patch as you suggested though.

Thank you.

-- 
Regards,

Laurent Pinchart
