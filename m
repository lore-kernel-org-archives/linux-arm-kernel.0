From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 4 Feb 2010 09:45:13 +0100
Subject: [PATCH 08/25] imx/mx1: rename files defining a machine to
	mach-$mach.c
In-Reply-To: <20100204012916.GC5274@k2>
References: <20100108161551.GA19007@pengutronix.de>
	<1262967452-24353-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<20100204012916.GC5274@k2>
Message-ID: <20100204084513.GB5380@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Amit,

On Wed, Feb 03, 2010 at 05:29:16PM -0800, Amit Kucheria wrote:
> On 10 Jan 08, Uwe Kleine-K?nig wrote:
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
> > Cc: Darius Augulis <augulis.darius@gmail.com>
> > Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
> > ---
> >  arch/arm/mach-mx1/Makefile                      |    4 ++--
> >  arch/arm/mach-mx1/{mx1ads.c => mach-mx1ads.c}   |    2 +-
> >  arch/arm/mach-mx1/{scb9328.c => mach-scb9328.c} |    2 +-
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> >  rename arch/arm/mach-mx1/{mx1ads.c => mach-mx1ads.c} (98%)
> >  rename arch/arm/mach-mx1/{scb9328.c => mach-scb9328.c} (98%)
> 
> Rethinking about this (based on a similar request for my i.MX5 submission), I
> think renaming the boards to mach-* is a bad idea.
> 
> Other SoCs (davinci, omap, msm, nomadik, etc.) use the board-* convention. We
> already use mach-* for the SoC directory names under arch/arm/. Naming the
> boards with mach-* will just cause more confusion.
Hmmm

I still prefer mach-* as the corresponding Kconfig variables are named
MACH_* and there is no unified meaning of "board".  For (I think) most
people here board describes the whole machine.  For some (e.g. me) a
board might only be a PCB where you have to plug in a module that comes
with the SoC.
(http://www.digi.com/products/model.jsp?lid=EN&pgid=37&pfid=19&mtid=2070&amtid=2070&pm=Y)

It think machine is precise for all of us.

And note the selecting Kconfig symbol for arch/arm/mach-omap is
ARCH_OMAP.  Ditto we have ARCH_DAVINCI, ARCH_MSM and ARCH_NOMADIK.
So we could rename these to arch-omap etc.  But then this conflicts with
the toplevel arch directory!?

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
