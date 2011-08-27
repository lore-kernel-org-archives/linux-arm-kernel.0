From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat, 27 Aug 2011 20:39:22 +0200
Subject: [PATCH 1/5] ARM: mx5: Allow CCM definitions to work on MX51 and
	MX53
In-Reply-To: <CAOMZO5DcLj+bVchVrk9+K+xvzjD7sZpvMjmM0W0-o_qbzFnd5A@mail.gmail.com>
References: <1314386521-29351-1-git-send-email-fabio.estevam@freescale.com>
	<20110827111943.GK31404@pengutronix.de>
	<CAOMZO5DcLj+bVchVrk9+K+xvzjD7sZpvMjmM0W0-o_qbzFnd5A@mail.gmail.com>
Message-ID: <20110827183922.GL31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 27, 2011 at 12:17:47PM -0300, Fabio Estevam wrote:
> On Sat, Aug 27, 2011 at 8:19 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Fri, Aug 26, 2011 at 04:21:57PM -0300, Fabio Estevam wrote:
> >> Allow CCM (Clock Control Module) definitions to work on MX51 and MX53
> >> by checking the cpu type in run-time and using the appropriate register bases.
> >
> > They already work on i.MX51 and i.MX53. They have different physical
> > addresses, but have (more or less accidently...) the same virtual
> > address.
> 
> Without this patch I get a kernel crash on MX53 at
> arch/arm/mach-mx5/system.c , when trying to read
> the following registers CCM registers:

The CCM base address is AIPS1 + x whereas the ARM base address is
AIPS2 + x. Maybe only the AIPS1 base addresses are the same.
Anyway, I would prefer having the registers defines as offsets to
a base and not as absolute addresses. Looking back it was a mistake
merging this. Having the registers as offsets is much more flexible.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
