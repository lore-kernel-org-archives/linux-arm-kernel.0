From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 02 Jan 2012 22:32:19 -0500 (EST)
Subject: [PATCH 11/20] ARM: plat-mxc: hook special idle handlers to
 arm_pm_idle
In-Reply-To: <20111225015322.GC8240@S2100-06.ap.freescale.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
 <1324288069-21940-12-git-send-email-nico@fluxnic.net>
 <20111225015322.GC8240@S2100-06.ap.freescale.net>
Message-ID: <alpine.LFD.2.02.1201022229460.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 25 Dec 2011, Shawn Guo wrote:

> Hi Nico,
> 
> On Mon, Dec 19, 2011 at 04:47:40AM -0500, Nicolas Pitre wrote:
> > ... and remove redundant include of <mach/system.h>.
> > 
> > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > ---
> >  arch/arm/mach-imx/mm-imx3.c             |    4 ++--
> >  arch/arm/mach-imx/pm-imx27.c            |    3 +--
> >  arch/arm/mach-mx5/mm.c                  |    2 +-
> 
> The hook imx_idle has been removed since v3.2-rc4 as suggested by rmk,
> so the context is changed here.

OK, will fix when I rebase.

> >  arch/arm/mach-mxs/pm.c                  |    3 +--
> 
> The mxs is a different sub-architecture/platform than imx/mxc, so it
> might be better to split it out.

Yes, in fact it is best to fold that change in the patch called
"ARM: substitute arch_idle()".


Nicolas
