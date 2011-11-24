From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 24 Nov 2011 08:14:06 +0100
Subject: BUG: sleeping function called from invalid context
In-Reply-To: <20111123225124.GK9581@n2100.arm.linux.org.uk>
References: <4ECCDAA2.4070502@prolan.hu>
 <CAOMZO5DSvLU0ACJPZ69tzY0PjMijibSzwCEwBhu=5=mg7ncF=g@mail.gmail.com>
 <20111123183640.GQ19986@pengutronix.de>
 <20111123225124.GK9581@n2100.arm.linux.org.uk>
Message-ID: <20111124071406.GS19986@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 10:51:24PM +0000, Russell King - ARM Linux wrote:
> On Wed, Nov 23, 2011 at 07:36:40PM +0100, Uwe Kleine-K?nig wrote:
> > Hello,
> > 
> > On Wed, Nov 23, 2011 at 10:44:50AM -0200, Fabio Estevam wrote:
> > > Looks like the same error I faced before:
> > > http://marc.info/?l=linux-arm-kernel&m=131914543319956&w=2
> > which resulted in some concerns about locking correctness. On i.MX28 we
> > usually use
> > 
> > 	http://thread.gmane.org/gmane.linux.ports.arm.kernel/100744/focus=100746
> > 
> > (though this patch wasn't accepted either. The right fix is to convert
> > mxs to the upcoming clk framework, which didn't land into mainline yet.)
> 
> Irrespective of the clk framework.  If you convert to the clk_prepare()
> methodology, then you fix this bug.  You can do this as a two-step thing.
Yeah, OK, I should have said:

	The right fix is to make clk_enable atomic on mxs which back
	then was agreed to be done when converting to the new clk
	framework.

> [..]
>
> So really, there's no excuse not to fix this for the imx/mxwhatever SoCs
> today - the clk framework is totally irrelevant as far as this goes.
I think doing the clk_prepare seperation and converting to the clk
framework in one step will be easier.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
