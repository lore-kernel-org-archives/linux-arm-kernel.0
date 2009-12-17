From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 17 Dec 2009 10:58:52 +0100
Subject: [PATCH 04/20] imx/clock-imx27: use a macro to define registers
In-Reply-To: <19241.56018.432600.636616@ipc1.ka-ro>
References: <20091216185046.GA16984@pengutronix.de>
	<1260990002-24168-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<19241.56018.432600.636616@ipc1.ka-ro>
Message-ID: <20091217095852.GC19548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Dec 17, 2009 at 08:16:34AM +0100, Lothar Wa?mann wrote:
> Hi,
> 
> Uwe Kleine-K?nig writes:
> > This way the base address isn't hard coded in each register definition
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Rabin Vincent <rabin@rab.in>
> > Cc: Javier Martin <javier.martin@vista-silicon.com>
> > Cc: Valentin Longchamp <valentin.longchamp@epfl.ch>
> > ---
> >  arch/arm/mach-mx2/clock_imx27.c |   30 ++++++++++++++++--------------
> >  1 files changed, 16 insertions(+), 14 deletions(-)
> > 
> > diff --git a/arch/arm/mach-mx2/clock_imx27.c b/arch/arm/mach-mx2/clock_imx27.c
> > index b010bf9..a533208 100644
> > --- a/arch/arm/mach-mx2/clock_imx27.c
> > +++ b/arch/arm/mach-mx2/clock_imx27.c
> > @@ -29,21 +29,23 @@
> >  #include <mach/common.h>
> >  #include <mach/hardware.h>
> >  
> > +#define IO_ADDR_CCM(off)	(IO_ADDRESS(CCM_BASE_ADDR) + (off))
> I would include the offset in the parameter for the IO_ADDRESS macro,
> so that the macro would check the complete address (including the
> offset) for validity:
> | +#define IO_ADDR_CCM(off)	(IO_ADDRESS((CCM_BASE_ADDR) + (off)))
> Otherwise e.g. a negative offset may lead to generation of bogus
> addresses.
I'd use

	#define IO_ADDR_CCM(off)	(IO_ADDRESS(CCM_BASE_ADDR + (off)))

and change it in a seperate patch.  And with negative addresses all bets
are off anyhow.

Grepping for "IO_ADDRESS\(.*\) *\+" finds some more places that want to
be fixed.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
