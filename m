From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 24 Jan 2011 11:04:35 +0100
Subject: [PATCH v2] Add i.MX23/28 auart support
In-Reply-To: <20110117112508.GA23185@freescale.com>
References: <1294924476-10653-1-git-send-email-s.hauer@pengutronix.de>
	<20110117112508.GA23185@freescale.com>
Message-ID: <20110124100435.GK9041@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Mon, Jan 17, 2011 at 07:25:09PM +0800, Shawn Guo wrote:
> Hi Sascha,
> 
> I tested the patch on mx28 evk with auart0 and auart3 connected with
> cross cable, and it works.  But when I try to get console on auart0
> with a direct-connecting cable, I do not see anything on console.
> 
> Did you verify it works for console?

Indeed it didn't work, see my latest series.

Sascha

> 
> On Thu, Jan 13, 2011 at 02:14:34PM +0100, Sascha Hauer wrote:
> > This is the second version of these patches. I have reworked the driver to
> > support the NPCK, BRKINT, PARMRK, IGNPAR, IGNBRK and cflag CREAD flags. I have
> > tested these flags to the best of my knowledge, but it's sometimes hard to
> > judge if the behaviour is expected.
> > 
> > Sascha
> > 
> > 
> > Sascha Hauer (2):
> >       serial: Add auart driver for i.MX23/28
> >       ARM MXS: Add auart platform support for i.MX28
> > 
> >  arch/arm/mach-mxs/clock-mx28.c                  |    5 +
> >  arch/arm/mach-mxs/devices-mx28.h                |    8 +
> >  arch/arm/mach-mxs/devices/Kconfig               |    3 +
> >  arch/arm/mach-mxs/devices/Makefile              |    1 +
> >  arch/arm/mach-mxs/devices/platform-auart.c      |   54 ++
> >  arch/arm/mach-mxs/include/mach/devices-common.h |   10 +
> >  drivers/serial/Kconfig                          |   15 +
> >  drivers/serial/Makefile                         |    1 +
> >  drivers/serial/mxs-auart.c                      |  806 +++++++++++++++++++++++
> >  9 files changed, 903 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-mxs/devices/platform-auart.c
> >  create mode 100644 drivers/serial/mxs-auart.c
> > 
> > 
> 
> -- 
> Regards,
> Shawn
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
