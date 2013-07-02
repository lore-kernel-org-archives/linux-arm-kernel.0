From: coelho@ti.com (Luciano Coelho)
Date: Tue, 2 Jul 2013 23:27:30 +0300
Subject: [PATCH v2 4/9] wl12xx: use frequency instead of enumerations
 for pdata clocks
In-Reply-To: <20130702150208.GA4233@kahuna>
References: <1372776948-24840-1-git-send-email-coelho@ti.com>
 <1372776948-24840-5-git-send-email-coelho@ti.com>
 <20130702150208.GA4233@kahuna>
Message-ID: <1372796850.21065.93.camel@cumari.coelho.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-07-02 at 10:02 -0500, Nishanth Menon wrote:
> On 17:55-20130702, Luciano Coelho wrote:
> > Instead of defining an enumeration with the FW specific values for the
> > different clock rates, use the actual frequency instead.  Also add a
> > boolean to specify whether the clock is XTAL or not.
> > 
> > Change all board files to reflect this.
> > 
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Sekhar Nori <nsekhar@ti.com>
> > Signed-off-by: Luciano Coelho <coelho@ti.com>
> > ---
> >  arch/arm/mach-davinci/board-da850-evm.c      |    3 +-
> >  arch/arm/mach-omap2/board-4430sdp.c          |    5 ++-
> ^^
> >  arch/arm/mach-omap2/board-omap3evm.c         |    3 +-
> >  arch/arm/mach-omap2/board-omap4panda.c       |    3 +-
> ^^
> Please do not add more platform data to platforms that are DT only.

Ah, I hadn't realized that board_omap4panda.c and board-4430sdp.c had
been removed in linux-next.  I base my tree on wireless-next and it
doesn't contain these changes yet.  I would only have noticed this when
I rebased my tree once the merge window is closed. ;)

Thanks for pointing out, I'll make sure these changes will not be there
when I send the pull request.

--
Cheers,
Luca.
