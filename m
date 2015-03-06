From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 6 Mar 2015 22:09:09 +0100
Subject: [PATCH 0/3] clk: divider: three exactness fixes (and a rant)
In-Reply-To: <54FA0385.2060808@codeaurora.org>
References: <20150221085620.GV19388@pengutronix.de>
 <1424515225-6929-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150306185730.11109.45998@quantum>
 <54FA0385.2060808@codeaurora.org>
Message-ID: <20150306210909.GI10717@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 06, 2015 at 11:44:05AM -0800, Stephen Boyd wrote:
> On 03/06/15 10:57, Mike Turquette wrote:
> >
> > Uwe,
> >
> > Thanks for the fixes. I'm thinking of taking all three for 4.0. I also
> > agree on clk_round_rate_nearest (along with a _ceil and _floor version
> > as well). That's something we can do for 4.1 probably.
> >
> > There are currently 3 users of CLK_DIVIDER_ROUND_CLOSEST:
> >
> > Loongson
> > QCOM
> > ST
> >
> > So now is probably the right time to remove the flag if we're going to
> > do it.
> >
> > What do you think?
> >
> 
> I may have had to do divider round closest on qcom platforms because of
> the problem these patches are for. I'll have to go back and look.
When you do that, also check if it works for you. I think the
implementation is broken for most of the cases.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
