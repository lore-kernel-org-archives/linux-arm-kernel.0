From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 29 Apr 2011 16:37:40 -0400 (EDT)
Subject: [PATCH 8/9] ARM: zImage: remove the static qualifier from global
	data variables
In-Reply-To: <20110429201237.GZ31131@pengutronix.de>
References: <1304031024-5121-1-git-send-email-nico@fluxnic.net>
	<1304031024-5121-9-git-send-email-nico@fluxnic.net>
	<20110429201237.GZ31131@pengutronix.de>
Message-ID: <alpine.LFD.2.00.1104291633000.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Apr 2011, Uwe Kleine-K?nig wrote:

> On Thu, Apr 28, 2011 at 06:50:23PM -0400, Nicolas Pitre wrote:
> > From: Nicolas Pitre <nicolas.pitre@linaro.org>
> > 
> > To be able to relocate the .bss section at run time independently from
> > the rest of the code, we must make sure that no GOTOFF relocations are
> > used with .bss symbols.  This usually means that no global variables can
> > be marked static unless they're also const.
> > 
> > Let's remove the static qualifier from current offenders, or turn them
> > into const variables when possible.  Next commit will ensure the build
> > fails if one of those is reintroduced due to otherwise enforced coding
> > standards for the kernel.
> > 
> > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > ---
> >  arch/arm/mach-davinci/include/mach/uncompress.h |    5 +++--
> >  arch/arm/mach-gemini/include/mach/uncompress.h  |    2 +-
> >  arch/arm/mach-iop32x/include/mach/uncompress.h  |    2 +-
> >  arch/arm/mach-iop33x/include/mach/uncompress.h  |    2 +-
> >  arch/arm/mach-ixp4xx/include/mach/uncompress.h  |    2 +-
> >  arch/arm/mach-mmp/include/mach/uncompress.h     |    2 +-
> >  arch/arm/mach-mxs/include/mach/uncompress.h     |    2 +-
> >  arch/arm/mach-ns9xxx/include/mach/uncompress.h  |    2 +-
> mach-ns9xxx is about to be removed. So maybe just drop the corresponding
> hunk.

Well, this is probably the easiest kind of merge conflict to solve, so 
unless I have other changes to make to this series I'll just leave it 
there for now.


Nicolas
