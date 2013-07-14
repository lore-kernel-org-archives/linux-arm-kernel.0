From: peter.chen@freescale.com (Peter Chen)
Date: Sun, 14 Jul 2013 08:43:04 +0800
Subject: [PATCH v2 1/1] ARM: imx: clk-pllv3: change wait method for PLL
 lock
In-Reply-To: <20130608010922.GA25105@nchen-desktop>
References: <1370593146-14025-1-git-send-email-peter.chen@freescale.com>
 <20130607082457.GF12361@pengutronix.de>
 <20130607083134.GE21641@nchen-desktop>
 <20130607083528.GG12361@pengutronix.de>
 <20130607084354.GF21641@nchen-desktop>
 <20130607084937.GH12361@pengutronix.de>
 <20130607110741.GB20756@S2101-09.ap.freescale.net>
 <20130608010922.GA25105@nchen-desktop>
Message-ID: <20130714004303.GA15443@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 08, 2013 at 09:09:23AM +0800, Peter Chen wrote:
> On Fri, Jun 07, 2013 at 07:07:43PM +0800, Shawn Guo wrote:
> > On Fri, Jun 07, 2013 at 10:49:38AM +0200, Uwe Kleine-K?nig wrote:
> > > > I will try your fix, but still it just reduces the possibilities.
> > > > The problem is not the preemption takes too long, it is the jiffies
> > > > updates more than one tick at one short preemption.
> > > If that is really the problem that many more instances that use the same
> > > incarnation need the same fix. I would be surprised if that was the
> > > case.
> > 
> > +1
> > 
> 
> Using uwe's patch, the pll lock timeout hasn't appeared during the
> overtime test, usually, it will occur 4 or 5 times during overnight
> test. The reason why I suspect jiffies update problem that is we
> meet the similiar issue at other drivers which timeout is 2 jiffies,
> but it is satisfied within 1ms.
> 
> I will do more test, if it is passed, I will send patch with uwe's suggestion.
> Thanks.

The root cause of this problem is timer problem, Jason has already submitted a patch
to fix this problem.

http://marc.info/?l=linux-arm-kernel&m=137109340222931&w=2

I will send a improvement patch with uwe's suggestion.

-- 

Best Regards,
Peter Chen
