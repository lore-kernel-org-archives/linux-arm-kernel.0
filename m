From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat, 3 Mar 2012 19:14:37 +0100
Subject: [PATCH 4/4] ARM i.MX 3ds debugboard: register a dummy regulator
 for the smsc911x device
In-Reply-To: <20120303163733.GC3071@opensource.wolfsonmicro.com>
References: <1330774804-7310-1-git-send-email-s.hauer@pengutronix.de>
 <1330774804-7310-5-git-send-email-s.hauer@pengutronix.de>
 <20120303163733.GC3071@opensource.wolfsonmicro.com>
Message-ID: <20120303181437.GJ26642@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 03, 2012 at 04:37:34PM +0000, Mark Brown wrote:
> On Sat, Mar 03, 2012 at 12:40:04PM +0100, Sascha Hauer wrote:
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  arch/arm/plat-mxc/3ds_debugboard.c |    9 +++++++++
> >  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> applied, though with at least this board you clearly do have a sensible
> regulator setup already and are just adding in a few extra regulators to
> fill out things which for some reason aren't supplied by the PMIC.  It's
> quite surprising that things like what look like the I/O reference
> voltage are supplied elsewhere.

This debug board is used with four different baseboards and one of them
indeed has regulator support in mainline. The regulator for the smsc911x
though is not software controllable on any of these boards. In the end
it's a debug board, energy efficiency might not be really important in
such a case.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
