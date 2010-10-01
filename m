From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 1 Oct 2010 14:42:58 +0200
Subject: [PATCH 1/2] Fixing ethernet driver compilation error for
	i.MX31 ADS board
In-Reply-To: <1285929216.1864.11401.camel@Tapajos>
References: <1285861655-6513-1-git-send-email-ian@opensource.wolfsonmicro.com>
	<20100930181433.GS29811@pengutronix.de>
	<1285929216.1864.11401.camel@Tapajos>
Message-ID: <20101001124258.GL784@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ian,

On Fri, Oct 01, 2010 at 11:33:36AM +0100, Ian Lartey wrote:
> On Thu, 2010-09-30 at 20:14 +0200, Uwe Kleine-K?nig wrote:
> > Hello,
> > 
> > On Thu, Sep 30, 2010 at 04:47:34PM +0100, Ian Lartey wrote:
> > > This is only a partial revert of "ARM: mx3/mx31ads: fold board header in
> > > its only user" [commit ccfa7c269843001077df02d98918c6c9bde91395)]
> > > 
> > > As some of the the board defines are also used in the cs89x0 ethernet
> > > driver by the i.MX31 ADS.
> > > 
> > > Signed-off-by: Ian Lartey <ian@opensource.wolfsonmicro.com>
> > It seems you got me wrong.  I wanted you to just define the constants in
> > arch/arm/plat-mxc/include/mach/board-mx31ads.h that are needed by the
> > cs89x0 driver.  That is PBC_BASE_ADDRESS, PBC_CS8900A_IOBASE and
> > EXPIO_INT_ENET_IAm I right in assuming NT.  And I wanted a comment like:
> > 
> > 	/* 
> > 	 * These symbols are used by drivers/net/cs89x0.c.
> > 	 * This is ugly as hell, but we have to provide them until
> > 	 * someone fixed the driver.
> > 	 */
> > 
> 
> Ah, yes it is _very ugly which was why I was trying everything else but
> I can understand your reasoning with the current state of the driver.
> 
> 
> Just to be clear. You want just the above defines in board-mx31ads.h and
> either:
> 
> 1. Common defines to be removed from board-mx31ads.c to board-mx31ads.h
> _or_
> 2. Duplicate defines in both board-mx31ads.c and board-mx31ads.h.
> 
> I'm assuming that you want 1. (2. is too ugly and dangerous). 
Right, I want 1.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
