From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 8 Dec 2010 10:39:27 +0100
Subject: [PATCH v2 04/15] ARM: mxs: Add interrupt support
In-Reply-To: <AANLkTin7jQ1uvnx1hU4Jj-j_YerKLgw=JXo6nDXmpa41@mail.gmail.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-3-git-send-email-shawn.guo@freescale.com>
	<20101207210352.GC14775@pengutronix.de>
	<AANLkTin7jQ1uvnx1hU4Jj-j_YerKLgw=JXo6nDXmpa41@mail.gmail.com>
Message-ID: <20101208093927.GI18244@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Wed, Dec 08, 2010 at 04:27:56PM +0800, Shawn Guo wrote:
> 2010/12/8 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > On Wed, Dec 08, 2010 at 12:31:54AM +0800, Shawn Guo wrote:
> [...]
> >> +
> >> +static void icoll_ack_irq(unsigned int irq)
> >> +{
> >> + ? ? __raw_writel(0, icoll_base + HW_ICOLL_VECTOR);
> > You need to write this before handling the irq, no? ?Note this question
> > is a repetition. ?You answered "No need, indeed. ?Will remove it."
> > According to MCIMX28RM a write to HW_ICOLL_VECTOR "indicates the
> > in-service state". ?Are you sure this is not needed? ?If no (i.e. it's
> > needed) the write should go into entry-macro.S. ?As I don't have
> > hardware yet I cannot test that. ?Maybe it's only needed when the
> > priority levels are used?!
> >
> Sorry. I made a mistake.  I thought I had tested the removal of line
> and gave the comment, but actually not. The line is needed, and image
> will stop working without the line.
> 
> Regarding to moving the writing to register VECTOR into entry-macro.S,
> can you please help me understand the reason behind the suggestion?
Section 5.2.1 of MCIMX28RM writes:

	After the CPU enters the interrupt service routine, it must
	notify the interrupt collector as soon as possible. Software
	indicates the in-service state by writing to the HW_ICOLL_VECTOR
	register.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
