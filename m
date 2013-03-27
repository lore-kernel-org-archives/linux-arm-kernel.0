From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 27 Mar 2013 16:14:54 +0100
Subject: [PATCH v2 5/5] ARM: imx: Remove cpufreq driver
In-Reply-To: <20130327140529.GG2674@S2101-09.ap.freescale.net>
References: <1364389294-1997-1-git-send-email-mpa@pengutronix.de>
 <1364389294-1997-6-git-send-email-mpa@pengutronix.de>
 <20130327140529.GG2674@S2101-09.ap.freescale.net>
Message-ID: <20130327151454.GC6347@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 10:05:31PM +0800, Shawn Guo wrote:
> On Wed, Mar 27, 2013 at 02:01:34PM +0100, Markus Pargmann wrote:
> > The old cpufreq driver is not necessary anymore with DT and
> > cpufreq-cpu0.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  arch/arm/Kconfig                      |   7 --
> >  arch/arm/mach-imx/Makefile            |   1 -
> >  arch/arm/mach-imx/cpu_op-mx51.c       |  31 -----
> >  arch/arm/mach-imx/cpu_op-mx51.h       |  14 ---
> >  arch/arm/mach-imx/cpufreq.c           | 206 ----------------------------------
> >  arch/arm/mach-imx/mach-cpuimx51sd.c   |   5 -
> >  arch/arm/mach-imx/mach-mx51_babbage.c |   4 -
> >  7 files changed, 268 deletions(-)
> >  delete mode 100644 arch/arm/mach-imx/cpu_op-mx51.c
> 
> Target cpu_op-mx51.o should be removed from Makefile then.
> 
> I fixed it up and applied the series expect the first patch.  I expect
> you will send follow-up patches to add imx51 operating-points into
> device tree though.

Thanks.

I just prepared a patch for mx51 babbage board. cpuimx51sd does not seem
to have a DTS file yet. In general I think the operating points have to
be in the board specific DTS files because the frequencies of imx51
devices are different.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
